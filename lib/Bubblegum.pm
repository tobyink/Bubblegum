# ABSTRACT: Opinionated Modern Perl Development Framework
package Bubblegum;

use 5.10.0;
use Moo 'with';

with 'Bubblegum::Role::Configuration';

# VERSION

sub import {
    my $target = caller;
    my $class  = shift;

    $class->prerequisites($target);
}

=head1 SYNOPSIS

    package Person;

    use Bubblegum::Class;
    use Bubblegum::Syntax -minimal;

    has 'firstname';
    has 'lastname';

    sub greet {
        my ($self, $subject) =
            (&_object, &_string);

        return sprintf 'Hello %s. My name is %s, nice to meet you.',
            $subject->titlecase, $self->firstname->titlecase;
    }

And elsewhere:

    my $jeff = Person->new(firstname => 'jeffrey');
    say $jeff->greet('amanda');

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

    use Bubblegum;
    # or Bubblegum::Class;
    # or Bubblegum::Role
    # or Bubblegum::Singleton;

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
desire to build-in data validation and design a system using roles for a higher
level of abstraction. The following functionality is made available simply by
using Bubblegum:

    # integers

        my $range = 5->to(1);                   # [ 5, 4, 3, 2, 1 ]

    # floats

        my $strip = 3.1415927->incr->int;       # 4

    # strings

        my $greet = 'hello world'->titlecase;   # "Hello World"

    # arrays

        my $alpha = ['a'..'z'];
        my $map   = $alpha->keyed(1..26);       # { 1=>'a', 2='b', ...}

    # hashes

        my $map = { 1=>'a', 2=>'b', 3=>'c' };
        $map->reset->set(1 => 'z');             # { 1=>'z', 2=undef, 3=>undef }

    # routines

        my $code = ['a'..'z']->iterator;
        my $char = $code->call;                 # a

    # comparison operations

        my $ten = "10";                         # string containing the 10
        $ten->eqtv(10)                          # false, type/value mismatch
        $ten->eq(10)                            # true, coercive comparison
        10->eq($ten)                            # true, same as above
        "10"->type                              # string
        (10)->type                              # integer
        10->typeof('aref')                      # false
        10->typeof('cref')                      # false
        10->typeof('href')                      # false
        10->typeof('int')                       # true
        10->typeof('nil')                       # false
        10->typeof('null')                      # false
        10->typeof('num')                       # true
        10->typeof('str')                       # false
        10->typeof('undef')                     # false

    # include Moo as your default object-system (optional)

        use Bubblegum::Class;                   # Bubblegum w/ Moo
        use Bubblegum::Role;                    # Bubblegum w/ Moo (Role)
        use Bubblegum::Singleton;               # Bubblegum w/ Moo (Singleton)

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

=over 4

=item *

Requires 5.10.0

=item *

Enforces Strict Syntax and Enables Warnings

=item *

Core Functions Throw Exceptions

=item *

Autoboxing With Consistent Functions Names

=item *

File and Path Utilities

=item *

Date and Time Utilities

=item *

Encoding and Decoding Utilities

=item *

UTF-8 Encoding For All IO Operations

=item *

Modern Method Order Resolution

=item *

Modern Minimalistic Object System

=item *

Flexible Type Constraint System

=item *

Optional Features and Enhancements

=back

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

=head2 Bubblegum Syntax

Additional features and enhancements can be enabled by using the
L<Bubblegum::Syntax> module which exports type constraint functions, data
validation functions and various utility functions. Hardcore Perl hackers around
the world are working tirelessly around the clock to give us a better system for
elegantly defining objects and classes using modern Perl best practices, ... but
in the meantime, have some Bubblegum.

    use Bubblegum;
    use Bubblegum::Syntax 'will';

    # take a moment to reason about the following Perl example.

    my $print = will '@output; say @output';
    $print->curry(1..10)->call; # 12345678910

Bubblegum is designed as a construction-kit; having it's feature-set
compartmentalized in such a way as to allow the maximum amount of
interoperability. Bubblegum can be used along-side any of the many
object-systems or development frameworks, e.g. L<Moo>, L<Moose>, L<Moops>,
L<Kavorka>, L<Functions::Parameters> and hopefully p5-mop (once it's added to
the Perl 5 core). Perl is all about choice and expressiveness; Bubblegum is all
about pushing Perl boundaries.

    package SpaceShip;

    use Bubblegum;
    use Bubblegum::Syntax -minimal;

    use Function::Parameters;
    use Try::Tiny;

    has _string 'name';

    method fire ($times) {
        return $self->name->format('The %s has fired %d times',
            _number $times);
    }

    package main;

    my $dstar = SpaceShip->new(name => 'DeathStar');
    say $dstar->fire(100);

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
wrappers (plugins) in a chain-able discoverable manner. It's also useful as a
technique for coercion and indirect object instantiation. The following is an
example:

    use Bubblegum;

    my $hash = {1..3,{4,{5,6,7,{8,9,10,11}}}};
    my $json = $hash->json; # load Bubblegum::Wrapper::Json dynamically
    say $json->encode;      # encode the hash as json

    # {"1":2,"3":{"4":{"7":{"8":9,"10":11},"5":6}}}

The follow list of wrappers are distributed with the Bubblegum distribution:

=head3 Digest Wrapper

The Bubblegum digest wrapper, L<Bubblegum::Wrapper::Digest>, provides access to
various hashing algorithms to encode/decode messages.

=head3 Dumper Wrapper

The Bubblegum data-dumper wrapper, L<Bubblegum::Wrapper::Dumper>, provides
functionality to encode/decode Perl data structures.

=head3 Encoder Wrapper

The Bubblegum encoding wrapper, L<Bubblegum::Wrapper::Encoder>, provides access
to content encoding/decoding functionality.

=head3 JSON Wrapper

The Bubblegum json wrapper, L<Bubblegum::Wrapper::Json>, provides functionality
to encode/decode Perl data structures as JSON documents.

=head3 YAML Wrapper

The Bubblegum yaml wrapper, L<Bubblegum::Wrapper::Yaml>, provides functionality
to encode/decode Perl data structures as YAML documents.

=head2 Bubblegum Data Type Operations

The following classes have methods which can be invoked by variables containing
data of a type corresponding with the type the class is designed to handle.

=head3 Array Operations

Array operations work on arrays and array references. Please see
L<Bubblegum::Object::Array> for more information on operations associated with
array references.

=head3 Code Operations

Code operations work on code references. Please see L<Bubblegum::Object::Code>
for more information on operations associated with code references.

=head3 Hash Operations

Hash operations work on hash and hash references. Please see
L<Bubblegum::Object::Hash> for more information on operations associated with
hash references.

=head3 Integer Operations

Integer operations work on integer and number data. Please see
L<Bubblegum::Object::Integer> for more information on operations associated with
integers.

=head3 Number Operations

Number operations work on data that meets the criteria for being a number.
Please see L<Bubblegum::Object::Number> for more information on operations
associated with numbers.

=head3 String Operations

String operations work on data that meets the criteria for being a string.
Please see L<Bubblegum::Object::String> for more information on operations
associated with strings.

=head3 Undef Operations

Undef operations work on variables whose value is undefined. Note, undef
operations do not work on undef directly. Please see L<Bubblegum::Object::Undef>
for more information on operations associated with undefined variables.

=head3 Universal Operations

Universal operations work on all data which meets the criteria for being
defined. Please see L<Bubblegum::Object::Universal> for more information on
operations associated with array references.

=cut

1;
