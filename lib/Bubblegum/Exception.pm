package Bubblegum::Exception;

use 5.10.0;

use strict;
use utf8::all;
use warnings;

use base 'Exception::Tiny';

# VERSION

sub data {
    return shift->{data};
}

1;
