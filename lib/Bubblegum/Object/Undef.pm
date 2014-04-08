# ABSTRACT: Common Methods for Operating on Undefined Values
package Bubblegum::Object::Undef;

use 5.10.0;
use Bubblegum::Class 'with';

with 'Bubblegum::Object::Role::Item';

# VERSION

sub defined {
    return 0
}

1;

=encoding utf8

=head1 SYNOPSIS

    use Bubblegum;

    my $nothing = undef;
    say $nothing->defined ? 'Yes' : 'No'; # No

=head1 DESCRIPTION

Undefined methods work on variables whose data meets the criteria for being
undefined. It is not necessary to use this module as it is loaded automatically
by the L<Bubblegum> class.

=cut

=method defined

    my $nothing = undef;
    $nothing->defined ? 'Yes' : 'No'; # No

The defined method always returns false.

=head1 SEE ALSO

L<Bubblegum::Object::Array>, L<Bubblegum::Object::Code>,
L<Bubblegum::Object::Hash>, L<Bubblegum::Object::Instance>,
L<Bubblegum::Object::Integer>, L<Bubblegum::Object::Number>,
L<Bubblegum::Object::Scalar>, L<Bubblegum::Object::String>,
L<Bubblegum::Object::Undef>, L<Bubblegum::Object::Universal>,

=cut
