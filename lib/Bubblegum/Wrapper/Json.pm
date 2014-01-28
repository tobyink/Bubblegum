package Bubblegum::Wrapper::Json;

use Bubblegum::Class;
use JSON::Tiny ();

extends 'Bubblegum::Object::Instance';

# VERSION

sub decode {
    my $self = shift;
    my $json = JSON::Tiny->new;
    return $json->decode($self->data);
}

sub encode {
    my $self = shift;
    my $json = JSON::Tiny->new;
    return $json->encode($self->data);
}

1;
