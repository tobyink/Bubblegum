# ABSTRACT: Opinionated Modern Perl Development Framework
package Bubblegum;

use Moo;

with 'Bubblegum::Role::Configuration';

# VERSION

sub import {
    my $target = caller;
    my $class  = shift;
    my @export = @_;
    my $base   = @_ == 1 && $export[0] eq '-base' ? 1 : 0;

    $class->prerequisites($target);
    Moo->import::into($target, @export) unless $base;
}

=head2 Introduction

Bubblegum makes essential core features and common functionality readily
available via automation (autoloading, autoboxing, autodying, etc). It promotes
modern Perl best practices by automatically enabling a standard configuration
(utf8::all, strict, warnings, features, etc) and by extending core functionality
with Bubblegum::Wrapper extensions. Bubblegum is an opinionated object-oriented
development framework, the core is designed to leverage as much of the Perl
core, 5.10+, as possible and uses Moo to provide a minimalistic object system
(compatible with Moose). This framework is modeled using object-roles for a
higher-level of abstraction and consistency.

=head2 Features

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

Please take a look at the Bubblegum overview L<Bubblegum::Overview> for more
information on it's features and usages.

=head2 Rationale

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

=cut

1;
