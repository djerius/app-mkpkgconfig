#============================================================================
# perl_compile.mk

PERL_COMPILE_SETUP = \
	if [ -n "$(pkgvdatadir)" ]; then \
	  p=`echo "$(PACKAGE)" | sed -e 's|[ -]|_|g'`; \
	  eval $${p}_pkgvdatadir="$(top_builddir)/lib"; \
	  export $${p}_pkgvdatadir ; \
	fi

PERL_COMPILE = $(PERL) $(PERLFLAGS) -wc
