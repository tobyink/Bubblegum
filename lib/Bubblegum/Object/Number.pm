# ABSTRACT: Common Methods for Operating on Numbers
package Bubblegum::Object::Number;

use Bubblegum::Class 'with';

with 'Bubblegum::Object::Role::Value';

# VERSION

=head1 SYNOPSIS

    use Bubblegum;

    my $number = 123456789;
    say $number->incr; # 123456790

=head1 DESCRIPTION

Number methods work on data that meets the criteria for being a number. A number
holds and manipulates an arbitrary sequence of bytes, typically representing
numberic characters (0-9).

=cut

=method abs

    my $number = 12;
    $number->abs; # 12

    $number = -12;
    $number->abs; # 12

The abs method returns the absolute value of the subject.

=cut

sub abs {
    my $self = CORE::shift;
    return CORE::abs $self;
}

=method atan2

    my $number = 1;
    $number->atan2(1); # 0.785398163397448

The atan2 method returns the arctangent of Y/X in the range -PI to PI

=cut

sub atan2 {
    my $self = CORE::shift;
    my $x    = bbblgm::chknum CORE::shift;
    return CORE::atan2 $self, $x;
}

=method cos

    my $number = 12;
    $number->cos; # 0.843853958732492

The cos method computes the cosine of the subject (expressed in radians).

=cut

sub cos {
    my $self = CORE::shift;
    return CORE::cos $self;
}

=method decr

    my $number = 123456789;
    $number->decr; # 123456788

The decr method returns the numeric subject decremented by 1.

=cut

sub decr {
    my $self = CORE::shift;
    my $n    = bbblgm::chknum CORE::shift if $_[0];
    return $self - ($n || 1);
}

=method exp

    my $number = 0;
    $number->exp; # 1

    $number = 1;
    $number->exp; # 2.71828182845905

    $number = 1.5;
    $number->exp; # 4.48168907033806

The exp method returns e (the natural logarithm base) to the power of the
subject.

=cut

sub exp {
    my $self = CORE::shift;
    return CORE::exp $self;
}

=method hex

    my $number = 175;
    $number->hex; # 0xaf

The hex method returns a hex string representing the value of the subject.

=cut

sub hex {
    my $self = CORE::shift;
    return CORE::sprintf '%#x', $self;
}

=method incr

    my $number = 123456789;
    $number->incr; # 123456790

The incr method returns the numeric subject incremented by 1.

=cut

sub incr {
    my $self = CORE::shift;
    my $n    = bbblgm::chknum CORE::shift if $_[0];
    return $self + ($n || 1);
}

=method int

    my $number = 12.5;
    $number->int; # 12

The int method returns the integer portion of the subject. Do not use this
method for rounding.

=cut

sub int {
    my $self = CORE::shift;
    return CORE::int $self;
}

=method log

    my $number = 12345;
    $number->log; # 9.42100640177928

The log method returns the natural logarithm (base e) of the subject.

=cut

sub log {
    my $self = CORE::shift;
    return CORE::log $self;
}

=method mod

    my $number = 12;
    $number->mod(1); # 0
    $number->mod(2); # 0
    $number->mod(3); # 0
    $number->mod(4); # 0
    $number->mod(5); # 2

The mod method returns the division remainder of the subject divided by the
argment.

=cut

sub mod {
    my $self    = CORE::shift;
    my $divisor = bbblgm::chknum CORE::shift;
    return $self % $divisor;
}

=method neg

    my $number = 12345;
    $number->neg; # -12345;

The neg method returns a negative version of the subject.

=cut

sub neg {
    my $self = CORE::shift;
    return -$self;
}

=method pow

    my $number = 12345;
    $number->pow; # 152399025

The pow method returns a number, the result of a math operation, which is the
subject to the power of the argument.

=cut

sub pow {
    my $self = CORE::shift;
    my $n    = bbblgm::chknum CORE::shift;
    return $self ** $n;
}

=method sin

    my $number = 12345;
    $number->sin; # -0.993771636455681

The sin method returns the sine of the subject (expressed in radians).

=cut

sub sin {
    my $self = CORE::shift;
    return CORE::sin $self;
}

=method sqrt

    my $number = 12345;
    $number->sqrt; # 111.108055513541

The sqrt method returns the positive square root of the subject.

=cut

sub sqrt {
    my $self = CORE::shift;
    return CORE::sqrt $self;
}

1;
