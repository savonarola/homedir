#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use File::Temp qw(tempfile);

my $bucket = $ARGV[0] or die "usage: $0 BUCKET\n";

sub run {
    my ($command) = @_;
    my $output = `$command`;
    my $exit_code = $? >> 8;

    die "Can't run command '$command', exit code $exit_code\n" if $exit_code;
    return $output;
}

my ($fh, $filename) = tempfile('scr_XXXXXXXXXXXXXXXXXXXXXXX', SUFFIX => '.png', DIR => '/tmp');
close $fh;
unlink $filename;

run "screencapture -i $filename";

my ($name,$path,$suffix) = fileparse($filename);

my $s3url = "s3://$bucket/$name";

run "s3cmd put -P $filename $s3url";
unlink $filename;

my $image_link = "https://s3.amazonaws.com/$bucket/$name";

run "/bin/echo -n $image_link | pbcopy";
print $image_link;


