package HomeDir;
use strict;
use base 'Exporter';
use Data::Dumper;

our @EXPORT = qw/run_cmd/; 

use HomeDir::Config::Include;


sub fs_separator{ "/" }
sub eol{ "\n" }
sub homedir{ (".homedir2") }
sub home{ $ENV{HOME} }
sub config_prefix{ "configs/" }


sub expand_homedir_path
{
    my ( $self, $path ) = @_;
    join $self->fs_separator(), $self->home(), $self->homedir(), $path;
}

sub expand_config_path
{
    my ( $self, $path ) = @_;
    join $self->fs_separator(), $self->home(), $path;
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
    $flags->{lc $uname} = 1;
}


sub install
{
    my ( $caller, $cfg, $flags ) = @_;
    $flags ||= {};
    $caller->add_auto_flags( $flags );
    my $configs = $cfg->{configs} || [];
    foreach my $config_rec ( @$configs ) {
        $caller->install_config( $config_rec, $flags );
    }
}

sub install_config
{
    my ( $self, $config_rec, $flags ) = @_;
    my $config_fname = $self->expand_config_path( $config_rec->{config} );
    my $config = HomeDir::Config::TextConfig->new( $config_fname );
    my $include_types = HomeDir::Config::Include->types();
    my @includes = ();
    foreach my $type ( @$include_types ) {
        my $recs = $config_rec->{$type} || [];
        $recs = [ $recs ] unless ref $recs eq 'ARRAY';
        $recs = [ map { 
            ref eq 'HASH' 
                ? $_
                : { files => $_.'' }
        } @$recs ];
        my @files = map {
            @{ $self->get_files( $_, $flags ) }
        } @$recs;
        my @uniq_files = keys %{{ map{ $_ => 1 } @files }};
        foreach my $file ( @uniq_files ) {
            my $include = HomeDir::Config::Include->create( $type, { file => $file } );
            push @includes, $include;
        }
    }
    $_->install( $config ) for @includes;
    $config->write();
}

sub get_files
{
    my ( $self, $rec, $flags ) = @_;
    my $rec_flags = $rec->{flags} || [];
    $rec_flags = [split /\s+/, $rec_flags] unless ref $rec_flags eq 'ARRAY';
    my $need_install = $rec_flags && @$rec_flags 
        ?  grep { $flags->{$_} } @$rec_flags
        :  1;
    return [] unless $need_install;
    my $files = $rec->{files} || [];
    $files = [$files] unless ref $files eq 'ARRAY';
    my $res = [ map { glob $_ } map { $self->config_prefix().$_ } @$files ];
    return $res;
}












1;
