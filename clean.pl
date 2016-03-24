#!/usr/bin/perl
use strict;
use warnings;

foreach my $file (glob($ENV{HOME}."/.*.backup-*")) {
    print "Removing $file\n";
    system rm => '-rf', $file;
}
