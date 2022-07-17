#!/usr/bin/perl
use strict;
use warnings;
use File::Basename qw(fileparse);
use File::Path qw(make_path);
use File::Spec::Functions qw(catfile);
use FindBin qw($Bin);
use POSIX qw(strftime);

my $BACKUP_ID = strftime("%F-%H%M%S", localtime())."-".int(rand(99999999));

my @INSTALL = (
    [".bash_profile", ""],
    [".bashrc", ""],
    [".editorconfig", ""],
    [".gitconfig", ""],
    [".oh-my-zsh/", ""],
    [".screenrc", ""],
    [".tmux.conf", ""],
    [".tools/", ""],
    [".vim/", ""],
    [".vimrc", ""],
    ["nvim/", ".config/nvim/"],
    [".zshrc", ""],

    [{git => "https://github.com/wbthomason/packer.nvim"}, ".local/share/nvim/site/pack/packer/start/packer.nvim"]
);

my @LOCALS = qw(
    .bashrc.local
    .gitconfig.local
    .vimrc.local
    .zshrc.local
);


install();
print "done\n";


sub install {
    foreach my $item (@INSTALL) {
        my ($from, $to) = @$item;
        install_item($from, $to);
    }

    foreach my $local (@LOCALS) {
        touch($local);
    }
}

sub install_item {
    my ($from, $to) = @_;
    if(ref($from)) {
        if(my $git_src = $from->{git}) {
            my $ref = $from->{ref};
            install_git($git_src, $to, $ref)
        }
    } else {
        install_local($from, $to)
    }
}

sub install_local {
    my ($rel_src, $rel_target) = @_;
    $rel_target ||= $rel_src;
    my $src = expand_src($rel_src);
    my $target = prepare_target($rel_target);

    print "[local] installing $src to $target\n";
    copy($src, $target);
}

sub install_git {
    my ($git_url, $rel_target, $ref) = @_;
    my $target = prepare_target($rel_target);

    print "[git] cloning $git_url to $target\n";
    git_clone($git_url, $target, $ref || 'master');
}

sub expand_src {
    my $rel_src = shift;
    return join_path($Bin, $rel_src);
}

sub touch {
    my $rel_target = shift;
    my $target = expand_target($rel_target);
    command(touch => $target);
}

sub copy {
    my ($src, $target) = @_;
    command(rsync => '-a', $src, $target);
    command(chmod => '-R', 'g-w', $target);
}

sub git_clone {
    my ($git_url, $target, $ref) = @_;
    command(git => 'clone', '--depth=1', '-b', $ref, $git_url, $target);
}

sub command {
    my @command = @_;
    print( join(" ", @command), "\n");
    system @command;
}

sub backup {
    my ($target, $rel_target) = @_;
    my $backup_target = join_path($ENV{HOME}, ".homedir_backup", $BACKUP_ID, $rel_target);
    prepare_path($backup_target);
    print "backuping $target to $backup_target\n";
    copy($target, $backup_target);
}

sub expand_target {
    my $rel_target = shift;
    return join_path($ENV{HOME}, $rel_target);
}

sub prepare_target {
    my $rel_target = shift;
    my $target = expand_target($rel_target);

    prepare_path($target);

    if(-e $target) {
        backup($target, $rel_target)
    }

    return $target;
}

sub join_path {
    my @items = @_;
    my $path = catfile(@items);
    my $last = pop(@items);
    if($last =~ m{/\z}) {
        $path .= "/";
    }
    return $path;
}

sub prepare_path {
    my $target = shift;

    my ($name, $path, $suffix) = fileparse($target);
    make_path($path, {verbose => 1});
}

