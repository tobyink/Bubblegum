# ABSTRACT: Bubblegum Wrapper around Data Dumping
package Bubblegum::Wrapper::Dumper;

use Bubblegum::Class;

use Data::Dumper ();

extends 'Bubblegum::Object::Instance';

# VERSION

=head1 SYNOPSIS

    use Bubblegum;

    my $data = {1..3,{4,{5,6,7,{8,9,10,11}}}};

    my $string  = $data->dumper->encode;
    my $hashref = $string->dumper->decode;

=head1 DESCRIPTION

L<Bubblegum::Wrapper::Dumper> is a Bubblegum wrapper which provides the ability
to endcode/decode Perl data structures. It is not necessary to use this module
as it is loaded automatically by the L<Bubblegum> class.

=cut

=method decode

The decode method deserializes the stringified Perl data structure using the
L<Data::Dumper> module.

=cut

sub decode {
    my $self = shift;
    return eval $self->data;
}

=method encode

The encode method serializes the Perl data structure using the L<Data::Dumper>
module with the following options; Indent=0, Sortkeys=1, and Terse=1.

=cut

sub encode {
    my $self = shift;
    return Data::Dumper->new([$self->data])
        ->Indent(0)->Sortkeys(1)->Terse(1)->Dump;
}

1;
