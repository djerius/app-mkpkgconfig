# Create automake macros.
include $(top_srcdir)/snippets/create_am_macros.mk

# The Perl source is package.pl.in.  If not, adjust CLEANFILES and EXTRA_DIST!
# Make sure to use @PERL@ and @VERSION@ in the .in file.

bin_SCRIPTS	= mkpkg-config

#-------------------------------------------------------------------
#

#!!! Only use += for the following automake macros!

# sources that must be made prior to compilation
BUILT_SOURCES           += 

# extra files to add to the distribution
EXTRA_DIST              += mkpkg-config.pl.in

# Any files make built.
CLEANFILES              += $(bin_SCRIPTS) mkpkg-config.pl

# Any files configure built
DISTCLEANFILES          +=

# Any files maintainer built(with autoconf, automake, etc)
MAINTAINERCLEANFILES    += Makefile.in

#-------------------------------------------------------------------
# Snippets go after here, unless their docs say otherwise

# all of the rules to generate perl executables
include $(top_srcdir)/snippets/perl_compile.mk
include $(top_srcdir)/snippets/perl_prog.mk

include $(top_srcdir)/snippets/substitute_config_variables.mk

# this must be an explicit list of man pages; no make variables allowed.
# currently, only section l man pages are supported.
dist_manl_MANS = mkpkg-config.l

PODS = mkpkg-config
include $(top_srcdir)/snippets/prog_pod_pl_in.mk
