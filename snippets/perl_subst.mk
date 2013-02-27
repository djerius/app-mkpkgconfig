#============================================================================
# perl_subst.mk
#
# substitutes into *.pl.in to generate %.pl

PERL_SUBST_MK =

# prerequisite checks
DOSUBST_MK +=

PERL_SUBST_DEPS = Makefile

# substitution rule
%.pl : %.pl.in $(PERL_SUBST_DEPS)
	p="$@"; f=$(strip_dir) \
	$(dosubst) $(srcdir)/$$f.in > $$f || { rm $$f ; false ; }
