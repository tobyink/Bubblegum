# ABSTRACT: Generic Container Class for Passing Data
package Bubblegum::Object::Instance;

use 5.10.0;
use Bubblegum::Class;

our @ISA = (); # non-object

# VERSION

has 'data' => (
    is => 'ro'
);

1;

=encoding utf8

=head1 SYNOPSIS

    use Bubblegum::Object::Instance;

    my $self = Bubblegum::Object::Instance->new(data => {1..4});
    $self->data; # {1=>2,3=>4}

=head1 DESCRIPTION

Bubblegum::Object::Instance is a container class which merely provides a
consistent interface for accessing and operating on various data structures. It
is not necessary to use this module as it is loaded automatically by the
L<Bubblegum> class.

=attr data

    $self->data(...);

The data attribute holds some arbitrary value to be operated on.

=head1 SEE ALSO

L<Bubblegum::Object::Array>, L<Bubblegum::Object::Code>,
L<Bubblegum::Object::Hash>, L<Bubblegum::Object::Instance>,
L<Bubblegum::Object::Integer>, L<Bubblegum::Object::Number>,
L<Bubblegum::Object::Scalar>, L<Bubblegum::Object::String>,
L<Bubblegum::Object::Undef>, L<Bubblegum::Object::Universal>,

=cut
