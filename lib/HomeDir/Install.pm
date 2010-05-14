package HomeDir::Install;
use strict;
use base 'HomeDir';

use HomeDir::Install::External;
use HomeDir::Install::Snippet;
use HomeDir::Install::File;

sub install_modules
{
    {
        external => 'HomeDir::Install::External',
        snippet => 'HomeDir::Install::Snippet',
        file => 'HomeDir::Install::File',
    }
}

sub types {
    my ( $self ) = @_;
    [ keys %{$self->install_modules()} ];
}

sub create
{
    my ($caller, $type, $params ) = @_;
    my $class = $caller->install_modules()->{$type} or die "Unknown include type $type";
    return $class->new( $params );
}



1;
