# ABSTRACT: Class Component System for Bubblegum via Moo::Role
package Bubblegum::Role;

use 5.10.0;
use Moo 'with';

with 'Bubblegum::Role::Configuration';

# VERSION

sub import {
    my $target = caller;
    my $class  = shift;
    my @export = @_;

    $class->prerequisites($target);
    Moo::Role->import::into($target, @export);
}

=head1 SYNOPSIS

    package CheckingService;

    use Bubblegum::Role;

    sub deposit {
        my $self = shift;
        my $amount = $self->balance + shift // 0;
        return $self->balance($amount);
    }

    sub withdrawl {
        my $self = shift;
        my $amount = $self->balance - shift // 0;
        return $self->balance($amount);
    }

    package BankAccount;

    use Bubblegum::Class;

    with 'CheckingService';

And elsewhere:

    my $account = BankAccount->new(balance => 100000);
    say $account->withdrawl(1500);

=head1 DESCRIPTION

Bubblegum::Role provides an object orientated system for defining class
components (often referred to as traits or roles) by way of L<Moo::Role>; and
activates all of the options enabled by the L<Bubblegum> module. Using this
module allows you to define Moo roles as if you were using Moo::Role directly.

    use Bubblegum::Role;

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
    use Moo::Role;

=cut

1;
