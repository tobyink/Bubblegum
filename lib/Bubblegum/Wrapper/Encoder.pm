package Bubblegum::Wrapper::Encoder;

use Bubblegum::Class;

use Bubblegum::Syntax 'raise';
use Encode 'find_encoding';

extends 'Bubblegum::Object::Instance';

# VERSION

sub BUILD {
    my $self = shift;

    $self->data->typeof('str') or raise
        CORE::sprintf q(Wrapper package "%s" requires string data), ref $self;
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
