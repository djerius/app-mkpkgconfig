#============================================================================
# prog_pod_pl_in.mk - generate program documentation from .pl.in input

# this snippet creates POD files from .pl.in files by implementing the
# standard substitutions and then orchestrates the creation of
# PostScript, HTML, and UNIX section l man pages from the POD.  see
# prog_pod_base.mk for more information.


# Prerequisites:
#	create_am_macros.mk
#	substitute_config_variables.mk

# The caller must define
#  PODS    - the list of documentation, basenames only

%.pod : $(srcdir)/%.pl.in
	rm -f $@
	p="$@"; f=$(strip_dir) \
	f=`echo $$f | sed -e 's|[.]pod$$||'` \
	 && $(do_subst) $(srcdir)/$$f.pl.in > $@.tmp
	mv $@.tmp $@

include $(top_srcdir)/snippets/prog_pod_base.mk

POD_SFX = .pod

# necessary for VPATH to get things right
POD_DIR = 

# make sure the generated file is distributed
EXTRA_DIST 		+= $(PODS:%=%$(POD_SFX))
MAINTAINERCLEANFILES	+= $(PODS:%=%$(POD_SFX))
