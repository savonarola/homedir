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
#    die Dumper( [ $path, -d $path ] );
    unless( -d $path ) {
        system( mkdir => '-p', $path ) and  die "Can't mkdir $path\n";
    }
    system( cp => '-rf', $self->{file}, $path ) and die "Can't install $self->{file} to $path\n";
}

1;
