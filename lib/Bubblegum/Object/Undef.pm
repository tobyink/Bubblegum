# ABSTRACT: Common Methods for Operating on Undefined Values
package Bubblegum::Object::Undef;

use Bubblegum::Class 'with';

with 'Bubblegum::Object::Role::Item';

# VERSION

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

=cut

sub defined {
    return 0
}

1;
