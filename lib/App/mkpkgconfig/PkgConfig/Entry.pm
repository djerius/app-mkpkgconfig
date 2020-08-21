package App::mkpkgconfig::PkgConfig::Entry;
use strict;
use warnings;

# ABSTRACT: Base class for PkgConfig Keywords and Variables

use Syntax::Construct qw( non-destructive-subst );

our $VERSION = 'v2.0.2';

use Regexp::Common 'balanced';

=method new

  $pkg = App::mkpkgconfig::PkgConfig::Entry->new( $name, $value );

Create a new PkgConfig::Entry object.

=cut

sub new {
    my ( $class, $name, $value ) = @_;

    bless { name => $name,
            value => $value,
            depends => _parse_dependencies( $value ),
            }, $class;
}

=attr name

The entry's name.

=cut

sub name            { return $_[0]->{name} }

=attr value

The entry's value.

=cut

sub value           { return $_[0]->{value} }

=method depends

  @depends = $entry->depends;

Returns a list of the names of the variables that the entry depends upon.

=cut

sub depends         { return @{ $_[0]->{depends} } }

sub _parse_dependencies {
    my @depends =
            map { s/(?:^[{])|(?:[}]$)//gr }
            $_[0] =~ /(?<!\$)\$$RE{balanced}{-parens => '{}'}/g;

    my %depends;
    @depends{@depends} = ();

    return [ keys %depends ];
}

package App::mkpkgconfig::PkgConfig::Entry::Variable;

use parent -norequire => 'App::mkpkgconfig::PkgConfig::Entry';

package App::mkpkgconfig::PkgConfig::Entry::Keyword;

use parent -norequire => 'App::mkpkgconfig::PkgConfig::Entry';

1;

# COPYRIGHT

__END__

=head1 DESCRIPTION

B<PkgConfig::Entry> is the base class for C<PkgConfig> variables and keywords.

Don't instantiate this class; instead, instantiate C<PkgConfig::Entry::Variable> and
instantiate C<PkgConfig::Entry::Keyword>.  They have the same API as C<PkgConfig::Entry>
