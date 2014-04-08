# ABSTRACT: Bubblegum Wrapper around YAML Serialization
package Bubblegum::Wrapper::Yaml;

use 5.10.0;
use Bubblegum::Class;
use Class::Load 'load_class';

extends 'Bubblegum::Object::Instance';

# VERSION

sub decode {
    my $self = shift;
    my $yaml = load_class('YAML::Tiny', -version => 1.56)->new;
    return $yaml->read_string($self->data);
}

sub encode {
    my $self = shift;
    my $yaml = load_class('YAML::Tiny', -version => 1.56)->new;

    $yaml->[0] = $self->data; # hack
    return $yaml->write_string($self->data);
}

1;

=encoding utf8

=head1 SYNOPSIS

    use Bubblegum;

    my $data = {1..3,{4,{5,6,7,{8,9,10,11}}}};

    my $string  = $data->yaml->encode;
    my $hashref = $string->yaml->decode;

=head1 DESCRIPTION

L<Bubblegum::Wrapper::Yaml> is a Bubblegum wrapper which provides the ability to
endcode/decode YAML data structures. It is not necessary to use this module as
it is loaded automatically by the L<Bubblegum> class. B<Note>, in order to use
this wrapper you will need to have L<YAML::Tiny> installed which is not a
required Bubblegum dependency and should have been installed separately.

=method decode

The decode method deserializes the stringified YAML structure using the
L<YAML::Tiny> module.

=method encode

The encode method serializes the Perl data structure using the L<YAML::Tiny>
module.

=cut
