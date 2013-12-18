# ABSTRACT: Common Methods for Operating on Integers
package Bubblegum::Object::Integer;

use Bubblegum::Class 'with';

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Comparison';
with 'Bubblegum::Object::Role::Coercive';
with 'Bubblegum::Object::Role::Value';

# VERSION

=head1 SYNOPSIS

    use Bubblegum;

    my $int = 10;
    say $int->downto(0); # [10,9,8,7,6,5,4,3,2,1,0]

=head1 DESCRIPTION

Integer methods work on data that meets the criteria for being an integer. An
integer holds and manipulates an arbitrary sequence of bytes, typically
representing numeric characters. Users of integers should be aware of the
methods that modify the integer itself as opposed to returning a new integer.
Unless stated, it may be safe to assume that the following methods copy, modify
and return new integers based on their subjects.

=cut

=method downto

    my $int = 10;
    $int->downto(0); # [10,9,8,7,6,5,4,3,2,1,0]

The downto method returns an array reference containing a range of integers
from the subject to the argument. Assumes the subject is greater than the
argument.

=cut

sub downto {
    my $self = CORE::shift;
    my $other = bbblgm::chknum CORE::shift;

    return [CORE::reverse $other..$self];
}

=method eq

    my $int = 98765;
    $int->eq(98765); # true
    $int->eq(098765); # true
    $int->eq(987650); # false

The eq method returns true if the argument matches the subject, otherwise
returns false.

=cut

sub eq {
    my $self  = CORE::shift;
    my $other = bbblgm::chknum CORE::shift;

    return $self == $other ? 1 : 0;
}

=method eqtv

    my $int = 123;
    $int->eqtv('123'); # 0; false
    $int->eqtv(123); # 1; true

The eqtv method returns true if the argument matches the subject's type and
value, otherwise returns false. This                             function is akin to the strict-comparison
operator in other languages.

=cut

sub eqtv {
    my $self  = CORE::shift;
    my $other = CORE::shift;

    return 0 if !CORE::defined $other;
    return ($self->type eq $other->type && $self == $other) ? 1 : 0;
}

=method format

    my $int = 500;
    $int->format('%.2f'); # 500.00

The format method returns an integer formatted using the argument as a template
and the subject as a variable using the same conventions as the 'sprintf'
function.

=cut

sub format {
    my $self   = CORE::shift;
    my $format = bbblgm::chkstr CORE::shift;

    return CORE::sprintf $format, $self;
}

=method gt

    my $int = 1;
    $int->gt(0); # 1; true
    $int->gt(1); # 0; false

The gt method performs binary "greater than" and returns true if the subject is
numerically greater than the argument. Note, this operation expects the argument
to be numeric.

=cut

sub gt {
    my $self  = CORE::shift;
    my $other = bbblgm::chknum CORE::shift;

    return $self > $other ? 1 : 0;
}

=method gte

    my $int = 1;
    $int->gte(0); # 1; true
    $int->gte(1); # 1; true
    $int->gte(2); # 0; false

The gte method performs binary "greater than or equal to" and returns true if
the subject is numerically greater than or equal to the argument. Note, this
operation expects the argument to be numeric.

=cut

sub gte {
    my $self  = CORE::shift;
    my $other = bbblgm::chknum CORE::shift;

    return $self >= $other ? 1 : 0;
}

=method lt

    my $int = 1;
    $int->lt(2); # 1; true
    $int->lt(1); # 0; false

The lt method performs binary "less than" and returns true if the subject is
numerically less than the argument. Note, this operation expects the argument to
be numeric.

=cut

sub lt {
    my $self  = CORE::shift;
    my $other = bbblgm::chknum CORE::shift;

    return $self < $other ? 1 : 0;
}

=method lte

    my $int = 1;
    $int->lte(1); # 1; true
    $int->lte(2); # 1; true
    $int->lte(0); # 0; false

The lte method performs binary "less than or equal to" and returns true if
the subject is numerically less than or equal to the argument. Note, this
operation expects the argument to be numeric.

=cut

sub lte {
    my $self  = CORE::shift;
    my $other = bbblgm::chknum CORE::shift;

    return $self <= $other ? 1 : 0;
}

=method ne

    my $int = 1;
    $int->ne(2); # 1; true
    $int->ne(1); # 0; false

The ne method returns true if the argument does not match the subject, otherwise
returns false.

=cut

sub ne {
    my $self  = CORE::shift;
    my $other = bbblgm::chknum CORE::shift;

    return $self != $other ? 1 : 0;
}

=method to

    my $int = 5;
    $int->to(10); # [5,6,7,8,9,10]
    $int->to(0); # [5,4,3,2,1,0]

The to method returns an array reference containing a range of integers from the
subject to the argument. If the subject is greater than the argument, the range
generated will be from greastest to least, however, if the subject is less than
the argument, the range generated will be from least to greatest.

=cut

sub to {
    my $self  = CORE::shift;
    my $range = bbblgm::chknum CORE::shift;

    return [$self..$range] if $self <= $range;
    return [CORE::reverse($range..$self)];
}

=method to_array

    my $int = 1;
    $int->to_array; # [1]

The to_array method is used for coercion and simply returns an array reference
where the first element contains the subject.

=cut

sub to_array {
    my $self = CORE::shift;
    return [$self];
}

=method to_code

    my $int = 1;
    $int->to_code; # sub { 1 }

The to_code method is used for coercion and simply returns a code reference
which always returns the subject when called.

=cut

sub to_code {
    my $self = CORE::shift;
    return sub {$self};
}

=method to_hash

    my $int = 1;
    $int->to_hash; # { 1 => 1 }

The to_hash method is used for coercion and simply returns a hash reference
with a single key and value, having the key and value both contain the subject.

=cut

sub to_hash {
    my $self = CORE::shift;
    return {$self=>$self};
}

=method to_integer

    my $int = 1;
    $int->to_integer; # 1

The to_integer method is used for coercion and simply returns the subject.

=cut

sub to_integer {
    my $self = CORE::shift;
    return $self;
}

=method to_string

    my $int = 1;
    $int->to_string; # '1'

The to_string method is used for coercion and simply returns the stringified
version of the subject.

=cut

sub to_string {
    my $self = CORE::shift;
    return "$self";
}

=method upto

    my $int = 0;
    $int->upto(10); # [0,1,2,3,4,5,6,7,8,9,10]

The upto method returns an array reference containing a range of integers
from the subject to the argument. Assumes the subject is lesser than the
argument.

=cut

sub upto {
    my $self = CORE::shift;
    my $other = bbblgm::chknum CORE::shift;

    return [$self..$other];
}

1;
