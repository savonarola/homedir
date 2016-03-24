#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use FindBin qw($Bin);
use POSIX qw(strftime);

my $INSTALL_ID = "backup-".strftime("%F-%H%M%S", localtime())."-".int(rand(99999999));

my @INSTALL = (
  [".bash_profile", ""],
  [".bashrc", ""],
  [".gitconfig", ""],
  [".screenrc", ""],
  [".tmux.conf", ""],
  [".tools", ""],
  [".vim", ""],
  [".vimrc", ""],
  [".zshrc", ""],
);

my @LOCALS = qw(
  .bashrc.local
  .gitconfig.local
  .vimrc.local
  .zshrc.local
);

sub install {
    foreach my $item (@INSTALL) {
        my ($from, $to) = @$item;
        $to ||= $from;
        install_file($from, $to);
    }

    foreach my $local (@LOCALS) {
        touch($local);
    }
}


sub install_file {
    my ($rel_src, $rel_target) = @_;
    my $src = expand_src($rel_src);
    my $target = expand_target($rel_target);

    if(-e $target) {
        backup($target)
    }

    print "Installing $src to $target\n";
    copy($src, $target);
}

sub expand_src {
    my $rel_src = shift;
    return $Bin."/".$rel_src;
}

sub expand_target {
    my $rel_target = shift;
    return $ENV{HOME}."/".$rel_target;
}

sub backup {
    my $target = shift;
    my ($name, $path, $suffix) = fileparse($target);
    my $backup_name = $path."/".$name.".".$INSTALL_ID.$suffix;
    print "Backuping $target to $backup_name\n";
    rename $target, $backup_name;
}

sub touch {
    my $rel_target = shift;
    my $target = expand_target($rel_target);
    print "Touching $target\n";
    system touch => $target;
}

sub copy {
    my ($src, $target) = @_;
    system cp => '-rf', $src, $target;
}

install();

print "Done\n";
