#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
AC_PREREQ([2.57])

AC_INIT([mkpkg-config],[1.5.3],[opticsoft@head.cfa.harvard.edu],[mkpkg-config])
AM_INIT_AUTOMAKE([ check-news ])
AC_CONFIG_SRCDIR([src/mkpkg-config.pl.in])


# Checks for programs.
AC_PATH_PROG(PERL,perl)
AC_PROG_INSTALL

m4_include(snippets/pod_docs.ac)

MST_DOSUBST

# Checks for libraries.
AC_PROG_PERL_MODULES( 
			Getopt::Long
			Pod::Usage
			, ,
			AC_MSG_ERROR([Need those Perl Modules!]) )


# Checks for library functions.
AC_CONFIG_FILES([Makefile
		 src/Makefile
		 ])
AC_OUTPUT
