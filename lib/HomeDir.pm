package HomeDir;
use strict;
use base 'Exporter';

our @EXPORT = qw/run_cmd/; 

use HomeDir::Config::Include;


sub fs_separator{ "/" }
sub eol{ "\n" }
sub homedir{ (".homedir2") }
sub home{ $ENV{HOME} }


sub expand_homedir_path
{
    my ( $self, @path ) = @_;
    join $self->fs_separator(), $self->home(), $self->homedir(), @path;
}

sub expand_config_path
{
    my ( $self, @path ) = @_;
    join $self->fs_separator(), $self->home(), @path;
}

sub run_cmd($$;@)
{
    my ( $message, $cmd, @args ) = @_;
    print $message, "\n" if $message;
    print join( ' ', $cmd, @args ), "\n";
    system( $cmd, @args ) == 0 
        or die "failed: $?\n";
}

sub add_auto_flags
{
    my ( $caller, $flags ) = @_;
    my $uname = `uname`;
    chomp $uname;
    $flags->{$uname} = 1;
}


sub install
{
    my ( $caller, $cfg, $flags ) = @_;
    $flags ||= {};
    $caller->add_auto_flags( $flags );
    foreach my $rec ( @$cfg ) {
        my $rec_flags = $rec->{flags};
        my $need_install = $rec_flags && @$rec_flags 
            ?  grep { $flags->{$_} } @$rec_flags
            :  1;
        my $type = $rec->{type};
        my $params = $rec->{params};
        my $include = HomeDir::Config::Include->create( $type, $params );
        $include->install();
    }
}

1;
