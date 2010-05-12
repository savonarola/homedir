package HomeDir::Config::TextConfig;
use strict;
use base 'HomeDir::Config';


sub new
{
    my ( $class, $path ) = @_;
    my $self = {};
    bless $self, ref $class || $class;
   
    if( -e $path ) {
        open my $fh, "<", $path or die "Can't read $path : $!\n";
        my @lines = <$fh>;
        close $fh;
        chomp for @lines;
        $self->{lines} = \@lines;
    } else {
        $self->{lines} = [];
    }
    $self->{path} = $path;
    return $self;
}

sub path
{
    my ( $self ) = @_;
    return $self->{path};
}


sub lines
{
    my ( $self ) = @_;
    return $self->{lines};
}

sub write
{
    my ($self) = @_;
    open my $fh, ">", $self->{path} or die "Can't write into $self->{path} : $!\n";
    print $fh $_, $self->eol()
        for @{$self->lines()};
    close $fh;
}

1;
