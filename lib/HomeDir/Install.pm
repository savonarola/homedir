package HomeDir::Install;
use strict;
use base 'HomeDir';

use HomeDir::Install::External;
use HomeDir::Install::VimExternal;
use HomeDir::Install::Snippet;
use HomeDir::Install::File;

sub install_modules
{
    {
        external => 'HomeDir::Install::External',
        snippet => 'HomeDir::Install::Snippet',
        vim_external => 'HomeDir::Install::VimExternal',
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

sub create_file
{
    my ($caller, $params ) = @_;
    return HomeDir::Install::File->new( $params );

}



1;
