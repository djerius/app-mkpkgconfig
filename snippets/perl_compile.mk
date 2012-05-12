#============================================================================
# perl_compile.mk
PERL_COMPILE_MK =

# some code may be created during the build process; it will be in 
# $(top_builddir)/lib.  other code may be static; it will be in
# $(top_srcdir)/lib.  The easiest way to handle this is to amend
# PERL5LIB  to include the above paths.  However, we have to
# ensure that we don't ignore PERLLIB if it is set

# the first stanza about pkgvdatadir is historical.
PERL_ENV_SETUP = \
	if [ -n "$(pkgvdatadir)" ]; then \
	  p=`echo "$(PACKAGE)" | sed -e 's|[ -]|_|g'`; \
	  eval $${p}_pkgvdatadir="$(top_builddir)/lib"; \
	  export $${p}_pkgvdatadir ; \
	fi ; \
	if [ -n "$$PERLLIB" -a -z "$$PERL5LIB" ]; then  \
	  PERLLIB="$(top_builddir)/lib:$(top_srcdir)/lib:$$PERLLIB"; \
	elif [ -n "$$PERL5LIB" ]; then \
	  PERL5LIB="$(top_builddir)/lib:$(top_srcdir)/lib:$$PERL5LIB"; \
	else \
	  PERL5LIB="$(top_builddir)/lib:$(top_srcdir)/lib"; \
	fi

PERL_COMPILE = $(PERL_ENV_SETUP); $(PERL) $(PERLFLAGS) $(PERL_BLIB) -wc
PERL_RUN = $(PERL_ENV_SETUP); $(PERL) $(PERLFLAGS) $(PERL_BLIB)
