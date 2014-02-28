# ABSTRACT: Bubblegum Wrapper around YAML Serialization
package Bubblegum::Wrapper::Yaml;

use Bubblegum::Class;

use YAML::Tiny ();

extends 'Bubblegum::Object::Instance';

# VERSION

=head1 SYNOPSIS

    use Bubblegum;

    my $data = {1..3,{4,{5,6,7,{8,9,10,11}}}};

    my $string  = $data->yaml->encode;
    my $hashref = $string->yaml->decode;

=head1 DESCRIPTION

L<Bubblegum::Wrapper::Yaml> is a Bubblegum wrapper which provides the ability to
endcode/decode YAML data structures. It is not necessary to use this module as
it is loaded automatically by the L<Bubblegum> class.

=cut

=method decode

The decode method deserializes the stringified YAML structure using the
L<YAML::Tiny> module.

=cut

sub decode {
    my $self = shift;
    my $yaml = YAML::Tiny->new;
    return $yaml->read_string($self->data);
}

=method encode

The encode method serializes the Perl data structure using the L<YAML::Tiny>
module.

=cut

sub encode {
    my $self = shift;
    my $yaml = YAML::Tiny->new;

    $yaml->[0] = $self->data; # hack
    return $yaml->write_string($self->data);
}

1;
