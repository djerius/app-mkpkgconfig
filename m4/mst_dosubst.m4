##							-*- Autoconf -*-

# _MST_DOSUBST
# serial 2
#----------
# generate mk-dosubst, which creates dosubst.in from autoconf -t
AC_DEFUN([_MST_DOSUBST],[
AC_SUBST([MST_DOSUBST_M4])
AC_PATH_PROG([PERL],[perl],[])
if test "x$PERL" = "x" ; then
   AC_MSG_ERROR( "Perl is required to build this package" );
fi

AC_REQUIRE([AX_ADD_AM_MACRO_STATIC])
AX_ADD_AM_MACRO_STATIC(
[DISTCLEANFILES += mk-dosubst
])
cat > mk-dosubst <<'EOF_DOSUBST'
#!perl
print <<'EOF';

package veval;

sub main::veval(@S|@) {
   my @S|@s = shift; @S|@s =~ s/@/\\@/g;
   @S|@s =~ s/\@S|@\@S|@/\\\@S|@/g;
   @S|@s =~ s/"/\\"/g;
   my (@S|@ret, @S|@nret ) = (@S|@s);
     @S|@ret = @S|@nret while @S|@ret ne (@S|@nret = eval qq@<:@qq@<:@@S|@ret@:>@@:>@);
   return @S|@ret
}

package main;
use Symbol 'qualify_to_ref';

my @S|@bound = <DATA>;
my ( @S|@var ) = @S|@bound =~ /^(\w+)\s/;
my @S|@value = '';
while ( <DATA> ) {

    if ( @S|@_ eq @S|@bound ) {

        chomp @S|@value;
        @S|@subst{@S|@var} = @S|@value;

	@S|@bound = <DATA>;
	( @S|@var ) = @S|@bound =~ /^(\w+)\s/;
	@S|@value = '';
    }

    else {
        @S|@value .= @S|@_;
    }
}

die( "unexpected end of substitution data\n" ) if defined @S|@bound;

*{qualify_to_ref(@S|@_, 'veval')} = \(@S|@subst{@S|@_}) foreach keys %subst;

@S|@subst{"@S|@{_}_EVAL"} = veval @S|@subst{@S|@_} foreach keys %subst;

while( @ARGV && @S|@ARGV@<:@0@:>@ =~ /(.*)=(.*)/ ) {
  @S|@subst{@S|@1} = @S|@2;
  shift;
}

@S|@re = join( '|', sort keys %subst );

while(<>) { s/@<:@@@:>@(@S|@re)@<:@@@:>@/@S|@subst{@S|@1}/geo; print; }

__DATA__
EOF

use Digest::MD5 qw@<:@ md5_base64 @:>@;

foreach ( <STDIN> ) {
    chomp;
    print @S|@_ . ' ' . md5_base64(@S|@_), "\n";
    print '@' . @S|@_ . '@' . "\n";
    print @S|@_ . ' ' . md5_base64(@S|@_), "\n";
}
EOF_DOSUBST
])

# MST_DOSUBST
#------------------
# Wrapper around _MST_DOSUBST so it is called just once
AC_DEFUN([MST_DOSUBST],
[AC_REQUIRE([_MST_DOSUBST])
])# MST_DOSUBST
