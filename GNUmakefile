
# template GNUmakefile file for a Perl program with POD documentation
# copy this to your source directory as GNUmakefile.

# Optional fields are commented out.  Required fields are not.

# Where the real makefiles live. Do *not* change this
TEMPLATE_ROOT=${AXAF_SIMUL_ROOT}/lib/templates/makefiles/

# The name of the program.  The actual Perl source file should have
# a .pl suffix.  This will be stripped upon installation.  Do *not*
# include it below
PROG = mkpkg-config

# any extra Perl flags
# PERL_FLAGS = 

# The option given to the program which will generate a version string
# of the form <progrname> <version>  where <version> has no white space,
# i.e.:  tidy_dir 1.5
VERSION_CMD = --version

# Documentation options. These shouldn't need to be changed.
DOC=$(PROG)
DOC_DIR=.
DOC_EXT=.pl

include $(TEMPLATE_ROOT)/prog_perl
include $(TEMPLATE_ROOT)/docs_pod
