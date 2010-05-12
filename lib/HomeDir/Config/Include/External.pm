package HomeDir::Config::Include::External;
use strict;
use base 'HomeDir::Config::Include';
use HomeDir::Config::TextConfig;

use Data::Dumper;

sub comment { "#" } 
sub include_external_cmd_pattern { "source %s " }
sub external_mark_pattern  { "%shomedir2:%s: do not modify this line manually" }


sub new
{
    my ( $caller, $params ) = @_;
   
    my $self = {
        external => $params->{external},
        target_config => $params->{target_config},
    };

    bless $self, ref $caller || $caller;
}

sub include_external_cmd 
{
    my ( $self ) = @_;
    sprintf $self->include_external_cmd_pattern(), $self->include_path( @{$self->{external}} );
}

sub external_mark
{
    my ( $self ) = @_;
    # join with '/' because this is not a real file path, just a mark
    sprintf $self->external_mark_pattern(), $self->comment(), join( '/', @{$self->{external}} );
}

sub include_external
{
    my ( $self ) = @_;
    $self->include_external_cmd().$self->external_mark();
}

sub search_position
{
    my ( $self, $config ) = @_;
    my $pos = undef;
    my $re = $self->external_mark()."\$";
    my $config_lines = $config->lines();
    my $i = 0; 
    foreach my $line (@$config_lines) {
        if ( $line =~ /$re/ ) {
            $pos = $i;
            last;
        } else {
            $i++;
        }
    }
    return $pos;
}

sub install
{
    my ($self) = @_;
    my $config = HomeDir::Config::TextConfig->new( @{$self->{target_config}} );
    my $pos = $self->search_position( $config );
    my $config_lines = $config->lines();
    if( defined $pos ) {
        splice @$config_lines, $pos, 1, ($self->include_external());
    } else {
        push @$config_lines, $self->include_external();
    }
    $config->write();
}

1;
