# ABSTRACT: Bubblegum Wrapper around Hashing Algorithms
package Bubblegum::Wrapper::Digest;

use Bubblegum::Class;

use Digest::MD5 ();
use Digest::SHA ();

use Bubblegum::Syntax 'raise';

extends 'Bubblegum::Object::Instance';

# VERSION

=head1 SYNOPSIS

    use Bubblegum;

    my $data = '...';
    $data->digest->encode;

=head1 DESCRIPTION

L<Bubblegum::Wrapper::Digest> is a Bubblegum wrapper which provides access to
various hashing algorithms to encode/decode messages. It is not necessary to use
this module as it is loaded automatically by the L<Bubblegum> class.

=cut

sub BUILD {
    my $self = shift;

    $self->data->typeof('str') or raise
        CORE::sprintf q(Wrapper package "%s" requires string data), ref $self;
}

=method encode

The encode method encodes the subject using the hashing algorithm specified,
the default hashing algorithm is md5_hex;

    my $data = '...';
    $data->digest->encode;
    $data->digest->encode('md5_hex'); #same
    $data->digest->encode('md5');
    $data->digest->encode('sha1');
    $data->digest->encode('sha1_base64');
    $data->digest->encode('sha1_hex');
    $data->digest->encode('hmac_sha1');
    $data->digest->encode('hmac_sha1_hex');

=cut

sub encode {
    my $self = shift;
    my $type = shift // 'md5_hex';

    my $encoder;
    my $md5 = [qw(md5 md5_hex)];
    my $sha = [qw(sha1_base64 sha1 sha1_hex)];
    my $hmc = [qw(hmac_sha1 hmac_sha1_hex)];

    $encoder = 'Digest::MD5' if $md5->one eq $type;
    $encoder = 'Digest::SHA' if $sha->one eq $type;
    $encoder = 'Digest::SHA' if $hmc->one eq $type;

    return undef unless $encoder;
    return $encoder->can($type)->($self->data);
}

1;
