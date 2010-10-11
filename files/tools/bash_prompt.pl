#!/usr/bin/perl -w
use strict;

use IPC::Open3 qw(open3);

my $pid = open3(\*CHLD_IN, \*CHLD_OUT, \*CHLD_ERR, qw(git  br));
my $output  = <CHLD_OUT>;
close CHLD_IN;
close CHLD_OUT;
close CHLD_ERR;
waitpid $pid, 0;

chomp $output;
$output =~s/^[\s\*]*//g;
$output =~s/[\s\*]*$//g;
print "[$output]";




