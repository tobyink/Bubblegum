# ABSTRACT: Common Methods for Operating on Scalars
package Bubblegum::Object::Scalar;

use 5.10.0;
use Scalar::Util ();

use Bubblegum::Class 'with';
use Bubblegum::Constraints -types;

with 'Bubblegum::Object::Role::Value';

our @ISA = (); # non-object

# VERSION

sub and {
    my ($self, $other) =  @_;
    return $self && $other;
}

sub not {
    my ($self) =  @_;
    return !$self;
}

sub or {
    my ($self, $other) =  @_;
    return $self || $other;
}

sub repeat {
    my $self   = CORE::shift;
    my $number = type_number CORE::shift;
    return $self x $number;
}

sub xor {
    my ($self, $other) =  @_;
    return ($self xor $other) ? 1 : 0;
}

1;

=encoding utf8

=head1 SYNOPSIS

    use Bubblegum;

    my $variable = 12345;
    say $variable->or(56789); # 12345

=head1 DESCRIPTION

Scalar methods work on data that meets the criteria for being a defined. It is
not necessary to use this module as it is loaded automatically by the
L<Bubblegum> class.

=method and

    my $variable = 12345;
    $variable->and(56789); # 56789

    $variable = 0;
    $variable->and(56789); # 0

The and method performs a short-circuit logical AND operation using the subject
as the lvalue and the argument as the rvalue and returns the last truthy value
or false.

=method not

    my $variable = 0;
    $variable->not; # 1

    $variable = 1;
    $variable->not; # ''

The not method performs a logical negation of the subject. It's the equivalent
of using bang (!) and return true (1) or false (empty string).

=method or

    my $variable = 12345;
    $variable->or(56789); # 12345

    $variable = 00000;
    $variable->or(56789); # 56789

The or method performs a short-circuit logical OR operation using the subject
as the lvalue and the argument as the rvalue and returns the first truthy value.

=method repeat

    my $variable = 12345;
    $variable->repeat(2); # 1234512345

    $variable = 'yes';
    $variable->repeat(2); # yesyes

The repeat method returns a string consisting of the subject repeated the number
of times specified by the argument.

=method xor

    my $variable = 1;
    $variable->xor(1); # 0
    $variable->xor(0); # 1

The xor method performs an exclusive OR operation using the subject as the
lvalue and the argument as the rvalue and returns true if either but not both
is true.

=head1 SEE ALSO

L<Bubblegum::Object::Array>, L<Bubblegum::Object::Code>,
L<Bubblegum::Object::Hash>, L<Bubblegum::Object::Instance>,
L<Bubblegum::Object::Integer>, L<Bubblegum::Object::Number>,
L<Bubblegum::Object::Scalar>, L<Bubblegum::Object::String>,
L<Bubblegum::Object::Undef>, L<Bubblegum::Object::Universal>,

=cut
