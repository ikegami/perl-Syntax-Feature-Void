package Syntax::Feature::Void;

use strict;
use warnings;

use version; our $VERSION = qv( 'v1.3.0' );

use XSLoader qw( );

XSLoader::load( 'Syntax::Feature::Void', $VERSION );

sub import   { $^H{ hint_key() } = 1; }
sub unimport { $^H{ hint_key() } = 0; }

*install   = \&import;    # For syntax.pm
*uninstall = \&unimport;  # For syntax.pm

1;


__END__

=head1 NAME

Syntax::Feature::Void - Provides the C<void> operator to force void context.


=head1 VERSION

Version 1.3.0


=head1 SYNOPSIS

    use syntax qw( void );

    sub f {
        void g();
    }

The above is functionally equivalent to the following:

    sub f {
        g();
        return;
    }


=head1 DESCRIPTION

Syntax::Feature::Void is a lexically-scoped pragma that
provides the C<void> operator to force void context.
Not that anyone needs that.

This module serves as a demonstration of the ability to
add keywords to the Perl language using
L<C<PL_keyword_plugin>|perlapi/PL_keyword_plugin>.


=head2 C<< use syntax qw( void ); >>

=head2 C<< use Syntax::Feature::Void; >>

Enables the use of C<void> until the end of the current lexical scope.


=head2 C<< no syntax qw( void ); >>

=head2 C<< no Syntax::Feature::Void; >>

Restores the standard behaviour of C<void> (a sub call) until the
end of the current lexical scope.


=head2 C<< void EXPR >>

Evalutes EXPR in void context.


=begin comment

=head1 Interal Subroutines

=over

=item * C<install>

=item * C<uninstall>

=item * C<hint_key>

=back

=end comment


=head1 SEE ALSO

=over 4

=item * L<syntax>

=item * L<perlapi>

=back


=head1 BUGS

Please report any bugs or feature requests to C<bug-Syntax-Feature-Void at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Syntax-Feature-Void>.
I will be notified, and then you'll automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Syntax::Feature::Void

You can also look for information at:

=over 4

=item * Search CPAN

L<http://search.cpan.org/dist/Syntax-Feature-Void>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Syntax-Feature-Void>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Syntax-Feature-Void>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Syntax-Feature-Void>

=back


=head1 AUTHOR

Eric Brine, C<< <ikegami@adaelis.com> >>


=head1 COPYRIGHT AND LICENSE

No rights reserved.

The author has dedicated the work to the Commons by waiving all of his
or her rights to the work worldwide under copyright law and all related or
neighboring legal rights he or she had in the work, to the extent allowable by
law.

Works under CC0 do not require attribution. When citing the work, you should
not imply endorsement by the author.


=cut
