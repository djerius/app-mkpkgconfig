include $(top_srcdir)/snippets/create_am_macros.mk

ACLOCAL_AMFLAGS = -I m4 --install
include $(top_srcdir)/aminclude_static.am

# Any files configure built
DISTCLEANFILES          += config.cache

# Any files maintainer built(with autoconf, automake, etc)
MAINTAINERCLEANFILES	+= \
			Makefile.in   \
			aclocal.m4    \
			config.guess  \
			config.h.in   \
			config.sub    \
			configure     \
			depcomp       \
			install-sh    \
			ltmain.sh     \
			missing       \
			mkinstalldirs


include %D%/src/Makefile.am

