#! /usr/bin/env /proj/axaf/bin/perl

use strict;
use warnings;

use Getopt::Long;
use File::Basename;
use File::Spec::Functions;

our ( $VERSION ) = '$Revision: 1.1.1.1 $' =~ /([\d.]+)/;
our $prog   = basename( $0, '.pl' );

our %param;

eval { main() };

do { warn $@; exit 1 } if $@;

exit 0;

sub main
{
  my @sARGV = @ARGV;
  parse_opts();

  help( 1 ) if $param{help};
  help( 2 ) if $param{usage};

  do { print( "$prog $VERSION\n" ); return }
    if $param{version};

  open( CONF, ">$param{output}" )
    or die ( "unable to open output stream\n" );

  print CONF "# This file was created by $prog ($VERSION)\n";
  print CONF join(' ', "# $prog", @sARGV), "\n";

  printf CONF "%s=%s\n", $_, $param{$_}
    foreach grep { defined $param{$_} }
      qw /pkg prefix exec_prefix libdir includedir/;

  print CONF "\n";

  foreach (
	   [ name  => 'Name' ],
	   [ desc  => 'Description' ],
	   [ pversion => 'Version' ],
	   [ req   => 'Requires' ],
	   [ conf  => 'Conflicts' ],
	   [ libs  => 'Libs' ],
	   [ cflags => 'Cflags' ] )
  {
    exists $param{$_->[0]} and 
      printf CONF "%s: %s\n", $_->[1], $param{$_->[0]};
  }
}


sub parse_opts
{

  %param = (
	    output => '-',
	    prefix => undef,
	    pversion => undef,
	    cflags => '',
	    desc => undef,
	    name => undef,
	   );

  eval {
    local $SIG{__WARN__} = sub { die $_[0] };

    GetOptions( \%param,
                qw (
                    output=s

		    prefix=s
		    exec_prefix=s
		    exec_suffix=s
		    libdir=s
		    includedir=s

		    pkg=s
		    name=s
		    desc=s
		    pversion=s
		    requires=s
		    conflicts=s
		    libs=s
		    cflags=s

                    version
                    help
                    usage
                   ),
	      );
  };

  die $@ if $@;

  return if $param{help} or $param{usage} or $param{version};

  my @notset = grep { !defined $param{$_} } keys %param;
  die ( 'parameter(s) `' , join( "`, `", @notset ), "' are not set\n" )
    if @notset;

  die( "can't specify both exec_suffix and exec_prefix\n" )
    if exists $param{exec_prefix} && $param{exec_suffix};

  $param{exec_prefix} ||= '${prefix}';

  $param{exec_prefix} = catfile('${prefix}', $param{exec_suffix} )
    if defined $param{exec_suffix};

  exists $param{libdir} or 
    $param{libdir}= catfile('${exec_prefix}', 'lib' );

  $param{includedir}  ||= catfile('${prefix}', 'include',
				  $param{pkg} || ()
				 );

  # generate libs field
  # add the libdir if it's there. also, add -l to arguments which aren't
  # preceded by it.
  $param{libs} ||= $param{pkg} || '';

  $param{libs} = join( ' ', 
		       ( $param{libdir} ? '-L${libdir}' : () ),
		       map { /^[-\/.]/ ? $_ : '-l' . $_ } 
		       split(/\s+|\s*,\s*/, $param{libs} ) );

  $param{cflags} = '-I${includedir}/${pkg}' . $param{cflags}
     if defined $param{pkg};

  $param{cflags} ||= '-I${includedir}';

}

sub help
{
  my ( $verbose ) = @_;

  # verbosity = 2 causes pod2usage to call perldoc, which already pages
  require IO::Pager::Page if $verbose < 2;
  require Pod::Usage;
  Pod::Usage::pod2usage ( { -exitval => 0, -verbose => $verbose } );
}

__END__

=pod

=head1 NAME

mkpkg-config - generate a configuration file for pkg-config

=head1 SYNOPSIS

mkpkg-config I<options>

=head1 DESCRIPTION

B<mkpkg-config> creates a B<pkg-config> metadata (C<.pc>) file based
upon command line options.  It is useful for inclusion in scripts.

It generates the following variables which may be interpolated into the
keywords: 

=over

=item C<pkg>

specifed by the B<--pkg> option.

=item C<prefix>

specified by the B<--prefix> option.

=item C<exec_prefix>

specified by the B<--exec_prefix> option.  It defaults to

  exec_prefix=${prefix}

If the B<--exec_suffix> option is specified instead of
B<--exec_prefix>, it defaults to

  exec_prefix=${prefix}/${exec_suffix}

=item C<libdir>

specified by the B<--libdir> option.  It defaults to

  libdir=${exec_prefix}/lib

=item C<includedir>

specified by the B<--includedir> option.  It defaults to

  includedir=${prefix}/include

=back


The following keywords are also generated:

=over

=item I<Name>

This is taken from the B<--name> option.

=item I<Description>

This is taken from the B<--desc> option.

=item I<Version>

This is taken from the B<--pversion> option.

=item I<Requires>

This is taken from the B<--requires> option.

=item I<Conflicts>

This is taken from the B<--conflicts> option.

=item I<Libs>

This is generated from the C<libdir> variable and the B<--libs>
option.  If C<libdir> is not i<empty>, C<-L${libdir}> is prepended to
I<Libs>.  If C<--libs> is not specified, C<-l${pkg}> is added (if
B<--pkg> is specified).

=item I<Cflags>

This is taken from the B<--cflags> options. If B<--pkg> is specified,
C<-I${includedir}/${pkg}> is prepended.

=back


=head1 OPTIONS

=head2 General Options

=over

=item --output

Where the configuration file is to be written.  It defaults to the
standard output stream.

=item --version

Print the version of B<mkpkg-config> and exit.

=item --help

Print a short help message and exit.

=item --usage

Print an extended usage message and exit.

=back

=head2 Variables

These are described in detail in L<Description>.

=over

=item --prefix

This parameter is required.

=item --exec_prefix

=item --libdir

=item --includedir

=item --pkg

=item --name

This parameter is required.

=item --desc

This parameter is required.

=item --pversion

This parameter is required.

=item --requires

=item --conflicts

=item --libs

=item --cflags

=back

=head1 EXAMPLES



=head1 LICENSE

Copyright 2004 the Smithsonian Astrophysical Observatory.  This
software is released under the GNU General Public License.  You may
find a copy at

        http://www.fsf.org/copyleft/gpl.html

=head1 AUTHOR

Diab Jerius ( E<gt>djerius@cfa.harvard.eduE<lt>)

