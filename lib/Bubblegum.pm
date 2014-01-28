# ABSTRACT: Opinionated Modern Perl Development Framework
package Bubblegum;

use Moo 'with';

with 'Bubblegum::Role::Configuration';

# VERSION

sub import {
    my $target = caller;
    my $class  = shift;

    $class->prerequisites($target);
}

=head1 SYNOPSIS

    use Bubblegum;

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

with the exception that Bubblegum implements it's own autoboxing architecture.
The Bubblegum autobox classes are the foundation for this development framework.
The decision to re-implement many core and autobox functions was based on the
desire to build-in data validation and design a system using object-roles for
a higher level of abstraction. The following functionality is made available
simply by using Bubblegum:

    # integers

        my $range = 10->to(1); # [ 10, 9, 8, 7, 6, 5, 4, 3, 2, 1 ]

    # floats

        my $strip = 3.1415927->incr->int; # 4

    # strings

        my $greet = 'hello world'->titlecase; # "Hello World"

    # arrays

        my $alpha = ['a'..'z'];
        my $map   = $alpha->keyed(1..26); # { 1=>'a', 2='b', ...}

    # hashes

        my $map = { 1=>'a', 2=>'b', 3=>'c', ...};
        $map->reset->set(1 => 'z'); # { 1=>'z', 2=undef, 3=>undef, ...}

    # routines

        my $code = ['a'..'z']->iterator;
        my $char = $code->call;

    # comparison operations

        my $ten = "10";             # string containing the number 10
        $ten->eqtv(10)              # false, strict compare type/value mismatch
        $ten->eq(10)                # true, value comparison with coercion
        10->eq($ten)                # true, same as above
        "10"->type                  # string
        (10)->type                  # integer
        10->typeof('nil')           # false
        10->typeof('num')           # true
        10->typeof('str')           # false

    # include Moo as your default object-system

        use Bubblegum::Class;       # with Moo
        use Bubblegum::Role;        # with Moo::Role
        use Bubblegum::Singleton;   # with Moo + Cached Instance

    # the gum function (for your convenience)

        say gum->script;            # Running /opt/app/repl

    # no more $FindBin::RealBin

        BEGIN {
            use Bubblegum;
            use lib gum->lib;       # equivalent to ./bin/lib
        }

    # assuming your script is located in a bin directory one level down
    # from where your lib directory is ...
    # or

        BEGIN {
            use Bubblegum;
            use lib gum->lib(1);    # equivalent to ./bin/../lib
        }

    # et al

        say [@INC]->join("\n");

=head1 DESCRIPTION

Bubblegum is a modern Perl development framework, it enforces common best
practices and is intended to be used to enhance your Perl environment and
development experience. The design goal of Bubblegum is to be as minimal as
possible, enabling as many core features as is justifiable, making the common
most repetitive programming tasks simply a method call away, and having all this
available by simply requiring this library. This framework is very opinionated
and designed around convention over configuration. Designed for adoption, all of
the techniques used in this framework are well-known by experienced Perl
developers and made conveniently available to programmers at all levels, i.e.,
no experimental features used. B<Note: This is an early release available for
testing and feedback and as such is subject to change.>

=head1 INTRODUCTION

Bubblegum makes essential core features and common functionality readily
available via automation (autoloading, autoboxing, autodying, etc). It promotes
modern Perl best practices by automatically enabling a standard configuration
(utf8::all, strict, warnings, features, etc) and by extending core functionality
with Bubblegum::Wrapper extensions. Bubblegum is an opinionated object-oriented
development framework, the core is designed to leverage as much of the Perl
core, 5.10+, as possible and uses Moo to provide a minimalistic object system
(compatible with Moose). This framework is modeled using object-roles for a
higher-level of abstraction and consistency.

=head1 FEATURES

    * 5.10.0 required
    * core functions throw exceptions
    * autoboxing with more consistent method names
    * file and path utilities
    * date and time utilities
    * encoding/decoding utilities
    * default utf-8 encoding for all IO operations
    * modern method order resolution
    * modern minimalistic object system
    * strict syntax checking
    * global utility object

=head1 RATIONALE

The TIMTOWTDI (there is more than one way to do it) motto has been a gift and a
curse. The Perl language (and community) has been centered around this concept
for quite some time, in that the language "doesn't try to tell the programmer
how to program" which makes it easy to write concise and powerful statements but
which also makes it easy to write extremely messy and incoherent software (with
great power comes great responsibility). Another downside is that as the number
of decisions a programmer has to make increases, their productivity decreases.
Enforced consistency is a path many other programming languages and frameworks
have adopted to great effect, so Bubblegum is one approach towards that end in
Perl.

=head2 Bubblegum Manifesto

    * develop locally, avoid system perl (try perlbrew, plenv, locallib, etc)
    * adopt an object-system, avoid rolling your own OO
    * always enable the strict and warnings pragmas
    * avoid variable-length routine arguments and return values
    * die honorably, with structured exceptions not strings

=head2 Bubblegum Environment Object

Bubblegum has an environment object, an instance of a kind-of utility class
containing methods which carry-out common programming tasks that are not
intrinsically tied to a particular data type. This utility object is made
accessible via the automatically exported gum function ("gum"), and is a
Bubblegum::Environment object, which also provides information about the system
and runtime environment. The global gum object is meant to provide easy access
to common routines, e.g., file and path routines, date and time routines, access
to environment variables and user information, as well as many other utility
functions like dumping and encoding data. This functions will be made available
once Bubblegum has been loaded unless it is already defined. There are lots of
handy methods which can be called on this object. The gum function (i.e. the
environment object) is useful for making common routines available to your
program without polluting the calling class' namespace.

    use Bubblegum;

    my $payday = gum->date('next friday');
    say 'My paycheck will be deposited on', $payday;


=head2 Bubblegum Topology

Bubblegum type classes are built as extensions to the autobox type classes. The
following is the custom autobox type, subtype and roles hierarchy. All native
data types inherit their functionality from the universal class, then whichever
autobox subtype class is appropriate and so on. Bubblegum overlays object-roles
on top of this design to enforce constraints and consistency. The following is
the current layout of the object roles and relationships. Note, this will likely
evolve.

    INSTANCE  -+
        [ROLE] VALUE
               |
    UNDEF     -+
        [ROLE] ITEM
               |
    UNIVERSAL -+
        [ROLE] DEFINED
               |
               +- SCALAR -+
               |     [ROLE] VALUE
               |          |
               |          +- NUMBER -+
               |          |     [ROLE] VALUE
               |          |          |
               |          |          +- INTEGER
               |          |          |     [ROLE] VALUE
               |          |          |
               |          |          +- FLOAT
               |          |                [ROLE] VALUE
               |          |
               |          +- STRING
               |                [ROLE] VALUE
               |
               +- ARRAY
               |     [ROLE] REF
               |     [ROLE] LIST
               |     [ROLE] INDEXED
               |
               +- HASH
               |     [ROLE] REF
               |     [ROLE] KEYED
               |
               +- CODE
                    [ROLE] VALUE

=head2 Bubblegum Wrappers

A Bubblegum::Wrapper module exists to extend Bubblegum itself and further extend
the functionality of native data types by letting the data bless itself into
wrappers (plugins) in a chainable discoverable manner. It's also useful as a
technique for coercion and indirect object instantiation. The following is an
example:

    use Bubblegum;

    my $hash = {1..3,{4,{5,6,7,{8,9,10,11}}}};
    my $json = $hash->json; # load Bubblegum::Wrapper::Json dynamically
    say $json->encode;      # encode the hash as json

    # {"1":2,"3":{"4":{"7":{"8":9,"10":11},"5":6}}}

Bubblegum ships with 5 wrappers, L<Bubblegum::Wrapper::Digest> for hashing,
L<Bubblegum::Wrapper::Dumper> for Perl serialization,
L<Bubblegum::Wrapper::Encoder> for content encoding, L<Bubblegum::Wrapper::Json>
for JSON serialization and L<Bubblegum::Wrapper::Yaml> for YAML serialization.

=head2 Bubblegum Type Methods

The following methods will can be called on their associated data type as if
the native types were blessed objects.

=head3 Array Methods

Array methods work on arrays and array references. Please see
L<Bubblegum::Object::Array> for more information on methods associated with
array references.

=head3 Code Methods

Code methods work on code references. Please see L<Bubblegum::Object::Code> for
more information on methods associated with code references.

=head3 Hash Methods

Hash methods work on hash and hash references. Please see
L<Bubblegum::Object::Hash> for more information on methods associated with hash
references.

=head3 Integer Methods

Integer methods work on integer and number data. Please see
L<Bubblegum::Object::Integer> for more information on methods associated with
integers.

=head3 Number Methods

Number methods work on data that meets the criteria for being a number. Please
see L<Bubblegum::Object::Number> for more information on methods associated
with numbers.

=head3 String Methods

String methods work on data that meets the criteria for being a string. Please
see L<Bubblegum::Object::String> for more information on methods associated
with strings.

=head3 Undef Methods

Undef methods work on variables whose value is undefined. Note, undef methods
do not work on undef directly. Please see L<Bubblegum::Object::Undef> for more
information on methods associated with undefined variables.

=head3 Universal Methods

Universal methods work on all data which meets the criteria for being defined.
Please see L<Bubblegum::Object::Universal> for more information on methods
associated with array references.

=cut

1;
