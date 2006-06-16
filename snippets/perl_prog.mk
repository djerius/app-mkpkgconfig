#============================================================================
# perl_prog.mk

# "compile" *.pl files to *.  substitutes into *.pl.in to generate %.pl

# prerequisite: substitute_config_variables.mk
# prerequisite: perl_compile.mk

# substitution rule
%.pl : %.pl.in Makefile 
	p="$@"; f=$(strip_dir) \
	$(do_subst) $(srcdir)/$$f.in > $$f || { rm $$f ; false ; }

# "compilation" rule
% : %.pl Makefile
	cp $< $@
	chmod +x $@
	$(PERL_COMPILE_SETUP) ; \
	$(PERL_COMPILE) $@ || { rm $@; false ; }
