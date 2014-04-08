# ABSTRACT: Common Methods for Operating on Code References
package Bubblegum::Object::Code;

use 5.10.0;
use Bubblegum::Class 'with';
use Bubblegum::Constraints -types;

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Ref';

# VERSION

sub call {
    my $self = CORE::shift;
    my @args = @_;
    return $self->(@args);
}

sub curry {
    my $self = CORE::shift;
    my @args = @_;
    return sub { $self->(@args, @_) };
}

sub rcurry {
    my $self = CORE::shift;
    my @args = @_;
    return sub { $self->(@_, @args) };
}

sub compose {
    my $self = CORE::shift;
    my $next = type_coderef CORE::shift;
    my @args = @_;
    return (sub { $next->($self->(@_)) })->curry(@args);
}

sub disjoin {
    my $self = CORE::shift;
    my $next = type_coderef CORE::shift;
    return sub { $self->(@_) || $next->(@_) };
}

sub conjoin {
    my $self = CORE::shift;
    my $next = type_coderef CORE::shift;
    return sub { $self->(@_) && $next->(@_) };
}

sub next {
    goto &call;
}

1;

=encoding utf8

=head1 SYNOPSIS

    use Bubblegum;

    my $code = sub { shift + 1 };
    say $code->call(2); # 3

=head1 DESCRIPTION

Code methods work on code references. It is not necessary to use this module as
it is loaded automatically by the L<Bubblegum> class.

=method call

    my $code = sub { (shift // 0) + 1 };
    $code->call; # 1
    $code->call(0); # 1
    $code->call(1); # 2
    $code->call(2); # 3

The call method executes and returns the result of the subject.

=method curry

    my $code = sub { [@_] };
    $code = $code->curry(1,2,3);
    $code->(4,5,6); # [1,2,3,4,5,6]

The curry method returns a code reference which executes the subject passing it
the arguments and any additional parameters when executed.

=method rcurry

    my $code = sub { [@_] };
    $code = $code->rcurry(1,2,3);
    $code->(4,5,6); # [4,5,6,1,2,3]

The rcurry method returns a code reference which executes the subject passing it
the any additional parameters and any arguments when executed.

=method compose

    my $code = sub { [@_] };
    $code = $code->compose($code, 1,2,3);
    $code->(4,5,6); # [[1,2,3,4,5,6]]

    # this can be confusing, here's what's really happening:
    my $listing = sub {[@_]}; # produces an arrayref of args
    $listing->($listing->(@args)); # produces a listing within a listing
    [[@args]] # the result

The compose method creates a code reference which executes the first argument
(another code reference) using the result from executing the subject as it's
argument, and returns a code reference which executes the created code reference
passing it the remaining arguments when executed.

=method disjoin

    my $code = sub { $_[0] % 2 };
    $code = $code->disjoin(sub { -1 });
    $code->(0); # -1
    $code->(1); #  1
    $code->(2); # -1
    $code->(3); #  1
    $code->(4); # -1

The disjoin method creates a code reference which execute the subject and the
argument in a logical OR operation having the subject as the lvalue and the
argument as the rvalue.

=method conjoin

    my $code = sub { $_[0] % 2 };
    $code = $code->conjoin(sub { 1 });
    $code->(0); # 0
    $code->(1); # 1
    $code->(2); # 0
    $code->(3); # 1
    $code->(4); # 0

The conjoin method creates a code reference which execute the subject and the
argument in a logical AND operation having the subject as the lvalue and the
argument as the rvalue.

=method next

    $code->next;

The next method is an alias to the call method. The naming is especially useful
(i.e. helps with readability) when used with closure-based iterators.

=head1 SEE ALSO

L<Bubblegum::Object::Array>, L<Bubblegum::Object::Code>,
L<Bubblegum::Object::Hash>, L<Bubblegum::Object::Instance>,
L<Bubblegum::Object::Integer>, L<Bubblegum::Object::Number>,
L<Bubblegum::Object::Scalar>, L<Bubblegum::Object::String>,
L<Bubblegum::Object::Undef>, L<Bubblegum::Object::Universal>,

=cut
