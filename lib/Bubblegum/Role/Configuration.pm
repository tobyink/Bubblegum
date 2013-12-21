package Bubblegum::Role::Configuration;

use Bubblegum::Constraint;

use 5.10.0;
use utf8::all;
use strict;
use warnings;
use Moo::Role;
use Class::Forward;
use Import::Into;
use Try::Tiny;

use mro     ();
use feature ();

use Carp 'croak';
use Class::Load 'load_class';
use Module::Find 'usesub';
use parent 'autobox';

requires 'import';

# VERSION

sub bbblgm::chk {
    goto &check;
}

sub bbblgm::chkarray {
    unshift @_, 'arrayref';
    goto &check;
}

sub bbblgm::chkcode {
    unshift @_, 'coderef';
    goto &check;
}

sub bbblgm::chkhash {
    unshift @_, 'hashref';
    goto &check;
}

sub bbblgm::chknum {
    unshift @_, 'number';
    goto &check;
}

sub bbblgm::chkref {
    unshift @_, 'ref';
    goto &check;
}

sub bbblgm::chkre {
    unshift @_, 'regexp';
    goto &check;
}

sub bbblgm::chkstr {
    unshift @_, 'string';
    goto &check;
}

sub bbblgm::croak {
    goto &croak;
}

sub bbblgm::forward {
    goto &forward;
}

sub bbblgm::instance {
    goto &instance;
}

sub bbblgm::load {
    goto &load;
}

sub bbblgm::mappings {
    goto &mappings;
}

sub check {
    my $type    = shift;
    my $value   = shift;
    my $context = [caller(1)];

    my $check = Bubblegum::Constraint->can("asa_$type")
        or croak "The constraint name ($type) is invalid";

    try {
        $check->($value);
    }
    catch {
        my $exception = $_[0];
        $exception->{context}{package} = $context->[0];
        $exception->{context}{file}    = $context->[1];
        $exception->{context}{line}    = $context->[2];
        die $exception;
    };
}

sub forward {
    my $name  = shift;
    my $space = Class::Forward->new(namespace => 'Bubblegum::Wrapper');
    load($space->forward($name));
}

sub instance {
    my $data = shift;
    load('Bubblegum::Object::Instance')->new(data => $data);
}

sub load {
    load_class @_;
}

sub mappings {{
    ARRAY     => 'Bubblegum::Object::Array',
    CODE      => 'Bubblegum::Object::Code',
    FLOAT     => 'Bubblegum::Object::Float',
    HASH      => 'Bubblegum::Object::Hash',
    INTEGER   => 'Bubblegum::Object::Integer',
    NUMBER    => 'Bubblegum::Object::Number',
    SCALAR    => 'Bubblegum::Object::Scalar',
    STRING    => 'Bubblegum::Object::String',
    UNDEF     => 'Bubblegum::Object::Undef',
    UNIVERSAL => 'Bubblegum::Object::Universal',
}}

sub prerequisites {
    my ($class, $target) = @_;
    my $ignore = ($target =~ /^Bubblegum::Object/);

    mro::set_mro $target, 'c3';
    usesub Bubblegum::Object unless $ignore;

    'utf8::all'->import::into($target);
    'strict'->import::into($target);
    'warnings'->import::into($target, qw(FATAL all));
    'autodie'->import::into($target, qw(:all));
    'feature'->import::into($target, qw(:5.10));

    # autobox
    $target->SUPER::import(%{mappings()});

    # $*
    $target ne 'Bubblegum::Environment' and eval q(
        package # hide
            bbblgm::env;

        no warnings 'all';
        require Bubblegum::Environment unless $ignore;
        require Tie::Scalar;
        $* = Bubblegum::Environment->new;
        tie $*, 'Bubblegum::Environment';
    );
}

1;
