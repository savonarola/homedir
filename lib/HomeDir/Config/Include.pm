package HomeDir::Config::Include;
use strict;
use base 'HomeDir';

use HomeDir::Config::Include::External;
use HomeDir::Config::Include::Snippet;
use HomeDir::Config::Include::File;

sub includes
{
    {
        external => 'HomeDir::Config::Include::External',
        snippet => 'HomeDir::Config::Include::Snippet',
        file => 'HomeDir::Config::Include::File',
    }
}

sub types {
    my ( $self ) = @_;
    [ keys %{$self->includes()} ];
}

sub create
{
    my ($caller, $type, $params ) = @_;
    my $class = $caller->includes()->{$type} or die "Unknown include type $type";
    return $class->new( $params );
}



1;
