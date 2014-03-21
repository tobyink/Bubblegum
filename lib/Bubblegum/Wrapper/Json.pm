# ABSTRACT: Bubblegum Wrapper around JSON Serialization
package Bubblegum::Wrapper::Json;

use Bubblegum::Class;
use Class::Load 'load_class';

extends 'Bubblegum::Object::Instance';

# VERSION

=head1 SYNOPSIS

    use Bubblegum;

    my $data = {1..3,{4,{5,6,7,{8,9,10,11}}}};

    my $string  = $data->json->encode;
    my $hashref = $string->json->decode;

=head1 DESCRIPTION

L<Bubblegum::Wrapper::Json> is a Bubblegum wrapper which provides the ability to
endcode/decode JSON data structures. It is not necessary to use this module as
it is loaded automatically by the L<Bubblegum> class. B<Note>, in order to use
this wrapper you will need to have L<JSON::Tiny> installed which is not a
required Bubblegum dependency and should have been installed separately.

=cut

=method decode

The decode method deserializes the stringified JSON structure using the
L<JSON::Tiny> module.

=cut

sub decode {
    my $self = shift;
    my $json = load_class('JSON::Tiny', -version => 0.45)->new;
    return $json->decode($self->data);
}

=method encode

The encode method serializes the Perl data structure using the L<JSON::Tiny>
module.

=cut

sub encode {
    my $self = shift;
    my $json = load_class('JSON::Tiny', -version => 0.45)->new;
    return $json->encode($self->data);
}

1;
