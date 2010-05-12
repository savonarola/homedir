package HomeDir::Config::TextConfig;
use strict;
use base 'HomeDir::Config';


sub new
{
    my ( $class, @path ) = @_;
    my $self = {};
    bless $self, ref $class || $class;
   
    my $full_path = $self->expand_config_path( @path );

    if( -e $full_path ) {
        open my $fh, "<", $full_path or die "Can't read $full_path : $!\n";
        my @lines = <$fh>;
        close $fh;
        chomp for @lines;
        $self->{lines} = \@lines;
    } else {
        $self->{lines} = [];
    }
    $self->{full_path} = $full_path;
    return $self;
}

sub full_path
{
    my ( $self ) = @_;
    return $self->{full_path};
}


sub lines
{
    my ( $self ) = @_;
    return $self->{lines};
}

sub write
{
    my ($self) = @_;
    open my $fh, ">", $self->{full_path} or die "Can't write into $self->{full_path} : $!\n";
    print $fh $_, $self->eol()
        for @{$self->lines()};
    close $fh;
}

1;
