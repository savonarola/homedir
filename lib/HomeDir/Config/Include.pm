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


sub include_path_prefix{ qw/configs/ }
sub include_path
{ 
    my ( $self, @path ) = @_;
    $self->expand_homedir_path( $self->include_path_prefix(), @path );
}


sub create
{
    my ($caller, $type, $params) = @_;
    my $class = $caller->includes()->{$type} or die "Unknown include type $type";
    return $class->new( $params );
}



1;
