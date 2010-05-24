#!/usr/bin/perl -w
use strict;
use FindBin qw/$Bin/;
use lib "$Bin/lib";
use HomeDir;

my $flags = map { $_ => 1 } @ARGV;

my $homedir = HomeDir->expand_homedir_path();

if( $Bin ne $homedir ) {
    run_cmd "Removing old homedir folder", 
        'rm', '-rf', $homedir;

    run_cmd "Installing new homedir folder",
        'cp', '-rf', $Bin, $homedir;
}

my $cfg_file = HomeDir->expand_homedir_path('config.pm');
my $cfg = do $cfg_file;
if( $@ ) {
    die "Error reading $cfg_file : $@\n";
}

HomeDir->install( $cfg, $flags );



