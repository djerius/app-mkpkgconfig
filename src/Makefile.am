bin_SCRIPTS	+= %D%/mkpkg-config

EXTRA_DIST              += %D%/mkpkg-config.pl.in
CLEANFILES              += %D%/$(bin_SCRIPTS) %D%/mkpkg-config.pl

#-------------------------------------------------------------------
# Snippets go after here, unless their docs say otherwise

# all of the rules to generate perl executables
include $(top_srcdir)/snippets/dosubst.mk
include $(top_srcdir)/snippets/perl_compile.mk
include $(top_srcdir)/snippets/perl_prog.mk
include $(top_srcdir)/snippets/perl_subst.mk

include $(top_srcdir)/snippets/doc_dirs.mk
include $(top_srcdir)/snippets/doc_man_init.mk

%C%_POD_SFX        = .pl
%C%_dist_manl_MANS = %D%/$(PACKAGE_NAME).l
%C%_PODS           = %D%/$(PACKAGE_NAME)
%C%_POD_HTML       = %D%/$(PACKAGE_NAME).html
%C%_POD_PDF        = %D%/$(PACKAGE_NAME).pdf

include %D%/pod_all.mk
