DOSUBST_MK =

BUILT_SOURCES		+= dosubst

noinst_SCRIPTS		+= dosubst

EXTRA_DIST		+= dosubst.in

CLEANFILES		+= dosubst

MAINTAINERCLEANFILES	+= dosubst.in

DOSUBST_ARGS =

dosubst : dosubst.in
	( cd $(top_builddir); ./config.status --file=$(subdir)/$@ )

dosubst.in : $(top_srcdir)/configure.ac
	( cd $(top_srcdir); autoconf -t 'AC_SUBST_TRACE:$$1' ) | $(PERL) $(top_builddir)/mk-dosubst > $@

dosubst = $(PERL) $(builddir)/dosubst $(DOSUBST_ARGS)
