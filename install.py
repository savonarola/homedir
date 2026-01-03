#!/usr/bin/env python3

import logging
import os
import subprocess
import sys
from datetime import datetime
from pathlib import Path
from random import randint


class GreyFormatter(logging.Formatter):
    GREY = '\033[90m'
    RESET = '\033[0m'

    def format(self, record):
        log_message = super().format(record)
        if record.levelno == logging.DEBUG:
            return f"{self.GREY}{log_message}{self.RESET}"
        return log_message


handler = logging.StreamHandler()
handler.setFormatter(GreyFormatter('%(levelname)s - %(message)s'))

logger = logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)
logger.addHandler(handler)


BACKUP_ID = f"{datetime.now().strftime('%Y-%m-%d-%H%M%S')}-{randint(0, 99999999):08d}"


INSTALL = {
    "ln": [
        (".editorconfig", ""),
        (".gitconfig", ""),
        (".tmux.conf", ""),
        (".zshrc", ""),
        (".zshrc.d/", ""),
        ("kitty.conf", ".config/kitty/kitty.conf"),
        ("nvim/", ".config/nvim/"),
    ],
    "git": [
        ("https://github.com/tmux-plugins/tpm", ".tmux/plugins/tpm", "master"),
    ],
    "rsync": [
        (".tools/", ""),
        (".ssh/", ""),
    ],
}


LOCALS = [
    ".bashrc.local",
    ".gitconfig.local",
    ".vimrc.local",
    ".zshrc.local",
    ".tmux.local.conf",
]


def run_command(*args):
    cmd_str = ' '.join(str(arg) for arg in args)
    logger.debug(f"Running: {cmd_str}")

    try:
        result = subprocess.run(
            args,
            check=True,
            capture_output=True,
            text=True
        )
        if result.stdout:
            logger.debug(f"stdout: {result.stdout.strip()}")
        if result.stderr:
            logger.debug(f"stderr: {result.stderr.strip()}")
        return result
    except subprocess.CalledProcessError as e:
        logger.error(f"Command failed with exit code {e.returncode}")
        if e.stdout:
            logger.error(f"stdout: {e.stdout.strip()}")
        if e.stderr:
            logger.error(f"stderr: {e.stderr.strip()}")
        raise


def get_script_dir():
    return Path(__file__).resolve().parent


def expand_src(rel_src):
    script_dir = get_script_dir()
    path = script_dir / rel_src
    if rel_src.endswith('/'):
        return str(path) + '/'
    return str(path)


def expand_target(rel_target):
    home = Path.home()
    path = home / rel_target
    if rel_target.endswith('/'):
        return str(path) + '/'
    return str(path)


def prepare_path(target):
    target_path = Path(target.rstrip('/'))
    parent = target_path.parent
    if not parent.exists():
        logger.info(f"Creating directory: {parent}")
        parent.mkdir(parents=True, exist_ok=True)


def backup(target, rel_target):
    home = Path.home()
    backup_dir = home / ".homedir_backup" / BACKUP_ID
    backup_target = backup_dir / rel_target

    if target.endswith('/'):
        backup_target = str(backup_target) + '/'
    else:
        backup_target = str(backup_target)

    logger.debug(f"Backing up {target} to {backup_target}")
    prepare_path(backup_target)
    run_command('rsync', '-a', target, backup_target)


def prepare_target(rel_target):
    target = expand_target(rel_target)
    prepare_path(target)

    target_check = target.rstrip('/')
    if os.path.exists(target_check):
        backup(target, rel_target)

    return target


def install_ln(rel_src, rel_target):
    if not rel_target:
        rel_target = rel_src

    src = expand_src(rel_src)
    target = prepare_target(rel_target)

    logger.info(f"[ln] {rel_src} -> {target.rstrip('/')}")
    run_command('ln', '-sf', src, target.rstrip('/'))


def install_rsync(rel_src, rel_target):
    if not rel_target:
        rel_target = rel_src

    src = expand_src(rel_src)
    target = prepare_target(rel_target)

    logger.info(f"[rsync] {rel_src} -> {target.rstrip('/')}")
    run_command('rsync', '-a', src, target)
    run_command('chmod', '-R', 'g-w', target.rstrip('/'))


def is_git_repo(path):
    git_dir = Path(path) / '.git'
    return git_dir.exists()


def get_git_origin(path):
    try:
        result = subprocess.run(
            ['git', '-C', path, 'remote', 'get-url', 'origin'],
            check=True,
            capture_output=True,
            text=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return None


def install_git(git_url, rel_target, ref='master'):
    target = expand_target(rel_target)
    target_check = target.rstrip('/')

    if os.path.exists(target_check):
        if is_git_repo(target_check):
            origin = get_git_origin(target_check)
            if origin == git_url:
                logger.info(f"[git] {git_url} -> {target_check} (update)")
                run_command('git', '-C', target_check, 'fetch', 'origin', ref)
                run_command('git', '-C', target_check, 'reset', '--hard', f'origin/{ref}')
                return

        prepare_target(rel_target)
        logger.info(f"Removing {target_check}")
        if os.path.islink(target_check):
            os.unlink(target_check)
        elif os.path.isdir(target_check):
            run_command('rm', '-rf', target_check)
        else:
            os.remove(target_check)
    else:
        prepare_path(target)

    logger.info(f"[git] {git_url} -> {target_check}")
    run_command('git', 'clone', '-b', ref, git_url, target_check)


def touch(rel_target):
    target = expand_target(rel_target)
    logger.debug(f"Touching {target}")
    run_command('touch', target)


def install():
    start_time = datetime.now()
    logger.info("=" * 60)
    logger.info(f"Starting dotfiles installation at {start_time.strftime('%Y-%m-%d %H:%M:%S')}")
    logger.info(f"Script directory: {get_script_dir()}")
    logger.info(f"Home directory: {Path.home()}")
    logger.info(f"Backup ID: {BACKUP_ID}")
    logger.info("=" * 60)

    for src, dest in INSTALL.get("ln", []):
        try:
            install_ln(src, dest)
        except Exception as e:
            logger.error(f"Failed to install (ln) {src}: {e}")
            raise

    for git_url, dest, ref in INSTALL.get("git", []):
        try:
            install_git(git_url, dest, ref)
        except Exception as e:
            logger.error(f"Failed to install (git) {git_url}: {e}")
            raise

    for src, dest in INSTALL.get("rsync", []):
        try:
            install_rsync(src, dest)
        except Exception as e:
            logger.error(f"Failed to install (rsync) {src}: {e}")
            raise

    logger.info(f"Creating {len(LOCALS)} local configuration files")
    for local_file in LOCALS:
        logger.info(f"Ensuring {local_file} exists")
        try:
            touch(local_file)
        except Exception as e:
            logger.error(f"Failed to touch {local_file}: {e}")
            raise

    end_time = datetime.now()
    logger.info("=" * 60)
    logger.info(f"Installation completed successfully at {end_time.strftime('%Y-%m-%d %H:%M:%S')}")
    logger.info("=" * 60)


def main():
    try:
        install()
        print("done")
        return 0
    except KeyboardInterrupt:
        logger.error("Installation interrupted by user")
        return 130
    except Exception as e:
        logger.error(f"Installation failed: {e}", exc_info=True)
        return 1


if __name__ == '__main__':
    sys.exit(main())
