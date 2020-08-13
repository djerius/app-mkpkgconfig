#============================================================================
# perl_subst.mk
#
# substitutes into *.pl.in to generate %.pl

PERL_SUBST_MK =

# prerequisite checks
DOSUBST_MK +=

PERL_SUBST_DEPS = Makefile

SUFFIXES += .pl.in .pl .pm.in .pm

# substitution rule
.pl.in.pl : $(PERL_SUBST_DEPS)
	$(dosubst) < $< > $@
.pm.in.pm : $(PERL_SUBST_DEPS)
	$(dosubst) < $< > $@
