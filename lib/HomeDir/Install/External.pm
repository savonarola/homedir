package HomeDir::Install::External;
use strict;
use base 'HomeDir::Install';

use Data::Dumper;

sub comment { "#" } 
sub include_external_cmd_pattern { "source %s " }
sub external_mark_pattern  { "%shomedir2:%s: do not modify this line manually" }


sub new
{
    my ( $caller, $params ) = @_;
   
    my $self = {
        external => $params->{file},
    };

    bless $self, ref $caller || $caller;
}

sub include_external_cmd 
{
    my ( $self ) = @_;
    sprintf $self->include_external_cmd_pattern(), $self->expand_homedir_path( $self->{external} );
}

sub external_mark
{
    my ( $self ) = @_;
    sprintf $self->external_mark_pattern(), $self->comment(), $self->{external};
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
    my ($self, $config ) = @_;
    my $pos = $self->search_position( $config );
    my $config_lines = $config->lines();
    if( defined $pos ) {
        splice @$config_lines, $pos, 1, ($self->include_external());
    } else {
        push @$config_lines, $self->include_external();
    }
}

1;
