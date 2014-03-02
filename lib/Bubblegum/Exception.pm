# ABSTRACT: General Purpose Exception Class for Bubblegum
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

=head1 SYNOPSIS

    Bubblegum::Exception->throw('oh nooo');

=head1 DESCRIPTION

Bubblegum::Exception provides a general purpose exception object to be thrown
and caught and rethrow. This module is derives from L<Exception::Tiny> and
provides all the functionality found in that module. Additionally, this module
allows you to include arbitrary data which can be access by the block which
catches the exception.

    try {
        Bubblegum::Exception->throw(
            message => 'you broke something',
            data    => $something
        );
    } catch ($exception) {
        if ($exception->data->isa('Something')) {
            $exception->rethrow;
        }
    }

=cut

1;
