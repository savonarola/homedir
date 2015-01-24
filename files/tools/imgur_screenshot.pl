#!/usr/bin/perl
use strict;
use warnings;

sub run {
    my ($command) = @_;
    my $output = `$command`;
    my $exit_code = $? >> 8;

    die "Can't run command '$command', exit code $exit_code\n" if $exit_code;
    return $output;
}

use File::Temp qw(tempfile);
my ($fh, $filename) = tempfile('imgur_upload_XXXXXX', SUFFIX => '.png', DIR => '/tmp');
close $fh;
unlink $filename;

run "screencapture -i $filename";
my $xml = run 'curl --form key='.$ENV{'IMGUR_KEY'}.' --form image=@'.$filename.' http://imgur.com/api/upload.xml -s';
unlink $filename;

$xml =~ m!<original_image>(.*?)</original_image>! or die "Can't upload image to imgur\n";
my $image_link = $1;

run "/bin/echo -n $image_link | pbcopy";
print $image_link;


