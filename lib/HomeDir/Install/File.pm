package HomeDir::Install::File;
use strict;
use base 'HomeDir::Install';

use Data::Dumper;


sub new
{
    my ( $caller, $params ) = @_;
   
    my $self = {
        file => $params->{file},
    };

    bless $self, ref $caller || $caller;
}

sub install
{
    my ($self, $path ) = @_;
    unless( -d $path ) {
        system( mkdir => '-p', $path ) or die "Can't mkdir $path\n";
    }
    system( cp => $self->{file}, $path ) or die "Can't install $self->{file} to $path\n";
}

1;
