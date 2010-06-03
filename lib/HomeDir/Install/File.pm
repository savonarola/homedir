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


sub normalize_path
{
    my ( $self, $path ) = @_;
    if( $path =~ m!^~/! ) {
        my $home = $ENV{HOME} or die "Can't expand ~/: \$HOME is not set\n";
        $path =~ s!^~!$home!;
    }
    return $path;

}

sub install
{
    my ($self, $path ) = @_;
    $path = $self->normalize_path($path);
#    die Dumper( [ $path, -d $path ] );
    

    unless( -d $path ) {
        $self->system( mkdir => '-p', $path ) and  die "Can't mkdir $path\n";
    }
    $self->system( cp => '-rf', $self->{file}, $path ) and die "Can't install $self->{file} to $path\n";
}

1;
