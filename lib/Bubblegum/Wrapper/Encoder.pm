# ABSTRACT: Bubblegum Wrapper around Content Encoding
package Bubblegum::Wrapper::Encoder;

use Bubblegum::Class;
use Bubblegum::Exception;

use Encode 'find_encoding';

extends 'Bubblegum::Object::Instance';

# VERSION

sub BUILD {
    my $self = shift;
    $self->data->typeof('str')
        or Bubblegum::Exception->throw(
            ref($self)->format('Wrapper package "%s" requires string data')
        );
}

sub decode {
    my $self = shift;
    my $type = shift // 'utf-8';
    my $decoder = find_encoding $type;

    return undef unless $decoder;
    return $decoder->decode($self->data);
}

sub encode {
    my $self = shift;
    my $type = shift // 'utf-8';
    my $encoder = find_encoding $type;

    return undef unless $encoder;
    return $encoder->encode($self->data);
}

1;

=encoding utf8

=head1 SYNOPSIS

    use Bubblegum;

    my $data = '...';
    $data->encoder->encode;

=head1 DESCRIPTION

L<Bubblegum::Wrapper::Encoder> is a Bubblegum wrapper which provides access to
content encoding using the encode/decode methods. It is not necessary to use
this module as it is loaded automatically by the L<Bubblegum> class.

=method decode

The decode method decodes the encoded string data using the encoding specified.
The default is utf-8 is no encoding is supplied.

=method encode

The encode method encodes the raw string data using the encoding specified.
The default is utf-8 is no encoding is supplied.

=cut
