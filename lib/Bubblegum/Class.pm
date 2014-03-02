# ABSTRACT: Object Orientation for Bubblegum via Moo
package Bubblegum::Class;

use 5.10.0;
use Moo 'with';

with 'Bubblegum::Role::Configuration';

# VERSION

sub import {
    my $target = caller;
    my $class  = shift;
    my @export = @_;

    $class->prerequisites($target);
    Moo->import::into($target, @export);
}

=head1 SYNOPSIS

    package BankAccount;

    use Bubblegum::Class;

    has 'balance' => (
        is      => 'rw',
        default => 0
    );

    sub withdrawl {
        my $self = shift;
        my $amount = $self->balance - shift // 0;
        return $self->balance($amount);
    }

And elsewhere:

    my $account = BankAccount->new(balance => 100000);
    say $account->withdrawl(1500);

=head1 DESCRIPTION

Bubblegum::Class provides object orientation for your classes by way of L<Moo>
and activates all of the options enabled by the L<Bubblegum> module. Using this
module allows you to define classes as if you were using Moo directly.

    use Bubblegum::Class;

is equivalent to

    use 5.10.0;
    use strict;
    use autobox;
    use autodie ':all';
    use feature ':5.10';
    use warnings FATAL => 'all';
    use English -no_match_vars;
    use utf8::all;
    use mro 'c3';
    use Moo;

=cut

1;
