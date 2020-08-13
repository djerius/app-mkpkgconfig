#============================================================================
# perl_prog.mk
#
# "compile" *.pl files to *.

PERL_PROG_MK =

# prerequisite checks
PERL_COMPILE_MK +=

# "compilation" rule. add "./" to path if $@ has no directory. workaround
# for bug in FindBin which doesn't handle bare filenames correctly,
# even if they are executables
% : %.pl Makefile
	cp $< $@
	chmod +x $@
	p="$@"; pp="$@" ; f=$(strip_dir); \
	test "$$p" = "$$f" && pp="./$$pp" ; \
	$(PERL_COMPILE) $$pp || { rm $@; false ; }
