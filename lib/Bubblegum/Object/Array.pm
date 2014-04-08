# ABSTRACT: Common Methods for Operating on Array References
package Bubblegum::Object::Array;

use 5.10.0;
use Bubblegum::Class 'with';
use Bubblegum::Constraints -types;

with 'Bubblegum::Object::Role::Defined';
with 'Bubblegum::Object::Role::Indirect';
with 'Bubblegum::Object::Role::Indexed';
with 'Bubblegum::Object::Role::List';
with 'Bubblegum::Object::Role::Ref';

use Syntax::Keyword::Junction::All  ();
use Syntax::Keyword::Junction::Any  ();
use Syntax::Keyword::Junction::None ();
use Syntax::Keyword::Junction::One  ();
use Scalar::Util ();

# VERSION

sub all {
    my $self = CORE::shift;
    return Syntax::Keyword::Junction::All->new(@$self);
}

sub any {
    my $self = CORE::shift;
    return Syntax::Keyword::Junction::Any->new(@$self);
}

sub clear {
    goto &empty;
}

sub count {
    goto &length;
}

sub defined {
    my $self  = CORE::shift;
    my $index = type_number CORE::shift;

    return CORE::defined $self->[$index];
}

sub delete {
    my $self  = CORE::shift;
    my $index = type_number CORE::shift;

    return CORE::delete $self->[$index];
}

sub each {
    my $self = CORE::shift;
    my $code = type_coderef CORE::shift;

    my $i=0;
    foreach my $value (@$self) {
        $code->($i, $value); $i++;
    }

    return $self;
}

sub each_key {
    my $self = CORE::shift;
    my $code = type_coderef CORE::shift;

    $code->($_) for (0..$#{$self});
    return $self;
}

sub each_n_values {
    my $self   = CORE::shift;
    my $number = $_[0] ? type_number CORE::shift : 2;
    my $code   = type_coderef CORE::shift;
    my @values = @$self;

    $code->(CORE::splice @values, 0, $number) while @values;
    return $self;
}

sub each_value {
    my $self = CORE::shift;
    my $code = type_coderef CORE::shift;

    $code->($self->[$_]) for (0..$#{$self});
    return $self;
}

sub empty {
    my $self = CORE::shift;

    $#$self = -1;
    return $self;
}

sub exists {
    my $self  = CORE::shift;
    my $index = type_number CORE::shift;
    return CORE::exists $self->[$index];
}

sub first {
    my $self = CORE::shift;
    return $self->[0];
}

sub get {
    my $self  = CORE::shift;
    my $index = type_number CORE::shift;
    return $self->[$index];
}

sub grep {
    my $self = CORE::shift;
    my $code = type_coderef CORE::shift;
    return [CORE::grep { $code->($_) } @$self];
}

sub hashify {
    my $self = CORE::shift;
    my $temp = {};

    for (CORE::grep { CORE::defined $_ } @$self) {
        $temp->{$_} = 1;
    }

    return $temp;
}

sub head {
    my $self = CORE::shift;
    return $self->[0];
}

sub iterator {
    my $self = CORE::shift;

    my $i = 0;
    return sub {
        return undef if $i > $#{$self};
        return $self->[$i++];
    }
}

sub join {
    my $self = CORE::shift;
    my $separator = type_string CORE::shift if $_[0];
    return CORE::join $separator // '', @$self;
}

sub keyed {
    my $self = CORE::shift;
    my @keys = @_;

    type_string $_ for @keys;

    my $i=0;
    return { CORE::map { $_ => $self->[$i++] } @keys };
}

sub keys {
    my $self = CORE::shift;
    return [0 .. $#{$self}];
}

sub last {
    my $self = CORE::shift;
    return $self->[-1];
}

sub length {
    my $self = CORE::shift;
    return CORE::scalar @$self;
}

sub list {
    my $self = CORE::shift;
    return (@$self);
}

sub map {
    my $self = CORE::shift;
    my $code = type_coderef CORE::shift;
    return [CORE::map { $code->($_) } @$self];
}

sub max {
    my $self = CORE::shift;
    my $max;

    for my $val (@$self) {
        next if CORE::ref($val);
        next if ! CORE::defined($val);
        next if ! Scalar::Util::looks_like_number($val);
        $max //= $val;
        $max = $val if $val > $max;
    }

    return $max;
}

sub min {
    my $self = CORE::shift;
    my $min;

    for my $val (@$self) {
        next if CORE::ref($val);
        next if ! CORE::defined($val);
        next if ! Scalar::Util::looks_like_number($val);
        $min //= $val;
        $min = $val if $val < $min;
    }

    return $min;
}

sub none {
    my $self = CORE::shift;
    return Syntax::Keyword::Junction::None->new(@$self);
}

sub nsort {
    my $self = CORE::shift;
    my $code = sub { $a <=> $b };
    return $self->sort($code);
}

sub one {
    my $self = CORE::shift;
    return Syntax::Keyword::Junction::One->new(@$self);
}

sub pairs {
    goto &pairs_array;
}

sub pairs_array {
    my $self = CORE::shift;
    my $i=0;
    return [CORE::map +[$i++, $_], @$self];
}

sub pairs_hash {
    my $self = CORE::shift;
    my $i=0;
    return {CORE::map {$i++ => $_} @$self};
}

sub pop {
    my $self = CORE::shift;
    return CORE::pop @$self;
}

sub push {
    my $self = CORE::shift;
    my @args = @_;

    CORE::push @$self, @args;
    return $self;
}

sub random {
    my $self = CORE::shift;
    return @$self[rand(1+$#{$self})];
}

sub reverse {
    my $self = CORE::shift;
    return [CORE::reverse @$self];
}

sub rotate {
    my $self = CORE::shift;
    CORE::push @$self, CORE::shift @$self;
    return $self;
}

sub rnsort {
    my $self = CORE::shift;
    my $code = sub { $b <=> $a };
    return $self->sort($code);
}

sub rsort {
    my $self = CORE::shift;
    my $code = sub { $b cmp $a };
    return $self->sort($code);
}

sub set {
    my $self  = CORE::shift;
    my $index = type_number CORE::shift;
    return $self->[$index] = CORE::shift;
}

sub shift {
    my $self = CORE::shift;
    return CORE::shift @$self;
}

sub size {
    goto &length;
}

sub slice {
    my $self = CORE::shift;
    my @indicies = @_;

    type_number $_ for @indicies;

    return [@$self[@indicies]];
}

sub sort {
    my $self = CORE::shift;
    my $code = type_coderef CORE::shift if $_[0];
    $code ||= sub { $a cmp $b };
    return [CORE::sort { $code->($a, $b) } @$self];
}

sub sum {
    my $self = CORE::shift;
    my $sum  = 0;

    for my $val (@$self) {
        next if CORE::ref($val);
        next if !CORE::defined($val);
        next if !Scalar::Util::looks_like_number($val);
        $sum += $val;
    }

    return $sum;
}

sub tail {
    my $self = CORE::shift;
    return [@$self[1 .. $#$self]];
}

sub unique {
    my $self = CORE::shift;

    my %seen;
    return [CORE::grep { not $seen{$_}++ } @$self];
}

sub unshift {
    my $self = CORE::shift;
    my @args = @_;

    CORE::unshift @$self, @args;
    return $self;
}

sub values {
    my $self = CORE::shift;
    return [@$self];
}

1;

=encoding utf8

=head1 SYNOPSIS

    use Bubblegum;

    my $array = [1..5];
    say $array->keyed('a'..'d'); # {a=>1,b=>2,c=>3,d=>4}

=head1 DESCRIPTION

Array methods work on array references. Users of these methods should be aware
of the methods that modify the array reference itself as opposed to returning a
new array reference. Unless stated, it may be safe to assume that the following
methods copy, modify and return new array references based on their subjects. It
is not necessary to use this module as it is loaded automatically by the
L<Bubblegum> class.

=method all

    my $array = [2..5];
    $array->all > 1; # 1; true
    $array->all > 3; # 0; false

The all method returns true if all of the elements in the subject meet the
criteria set by the operand and rvalue.

=method any

    my $array = [2..5];
    $array->any > 5; # 0; false
    $array->any > 3; # 1; true

The any method returns true if any of the elements in the subject meet the
criteria set by the operand and rvalue.

=method clear

    my $array = ['a'..'g'];
    $array->clear; # []

The clear method is an alias to the empty method.

=method count

    my $array = [1..5];
    $array->count; # 5

The count method returns the number of elements within the subject.

=method defined

    my $array = [1,2,undef,4,5];
    $array->defined(2); # 0; false
    $array->defined(1); # 1; true

The defined method returns true if the element within the subject at the index
specified by the argument meets the criteria for being defined, otherwise it
returns false.

=method delete

    my $array = [1..5];
    $array->delete(2); # 3

The delete method returns the value of the element within the subject at the
index specified by the argument after removing it from the array.

=method each

    my $array = ['a'..'g'];
    $array->each(sub{
        my $index = shift; # 0
        my $value = shift; # a
        ...
    });

The each method iterates over each element in the subject, executing the code
reference supplied in the argument, passing the routine the index and value at
the current position in the loop.

=method each_key

    my $array = ['a'..'g'];
    $array->each_key(sub{
        my $index = shift; # 0
        ...
    });

The each_key method iterates over each element in the subject, executing the
code reference supplied in the argument, passing the routine the index at the
current position in the loop.

=method each_n_values

    my $array = ['a'..'g'];
    $array->each_n_values(4, sub{
        my $value_1 = shift; # a
        my $value_2 = shift; # b
        my $value_3 = shift; # c
        my $value_4 = shift; # d
        ...
    });

The each_n_values method iterates over each element in the subject, executing
the code reference supplied in the argument, passing the routine the next n
values until all values have been seen.

=method each_value

    my $array = ['a'..'g'];
    $array->each_value(sub{
        my $value = shift; # a
        ...
    });

The each_value method iterates over each element in the subject, executing the
code reference supplied in the argument, passing the routine the value at the
current position in the loop.

=method empty

    my $array = ['a'..'g'];
    $array->empty; # []

The empty method drops all elements from the subject. Note, this method modifies
the subject.

=method exists

    my $array = [1,2,3,4,5];
    $array->exists(5); # 0; false
    $array->exists(0); # 1; true

The exists method returns true if the element within the subject at the index
specified by the argument exists, otherwise it returns false.

=method first

    my $array = [1..5];
    $array->first; # 1

The first method returns the value of the first element in the subject.

=method get

    my $array = [1..5];
    $array->get(0); # 1;

The get method returns the value of the element in the subject at the index
specified by the argument.

=method grep

    my $array = [1..5];
    $array->grep(sub{
        shift >= 3
    });

    # [3,4,5]

The grep method iterates over each element in the subject, executing the
code reference supplied in the argument, passing the routine the value at the
current position in the loop and returning a new array reference containing
the elements for which the argument evaluated true.

=method hashify

    my $array = [1..5];
    $array->hashify; # {1=>1,2=>1,3=>1,4=>1,5=>1}

The hashify method returns a hash reference where the elements of subject become
the hash keys and the corresponding values are assigned a value of 1. Note,
undefined elements will be dropped.

=method head

    my $array = [1..5];
    $array->head; # 1

The head method returns the value of the first element in the subject.

=method iterator

    my $array = [1..5];
    my $iterator = $array->iterator;
    while (my $value = $iterator->next) {
        say $value; # 1
    }

The iterator method returns a code reference which can be used to iterate over
the subject. Each time the iterator is executed it will return the next element
in the subject until all elements have been seen, at which point the iterator
will return an undefined value.

=method join

    my $array = [1..5];
    $array->join; # 12345
    $array->join(', '); # 1, 2, 3, 4, 5

The join method returns a string consisting of all the elements in the subject
joined by the join-string specified by the argument. Note, if the argument is
omitted, an empty string will be used as the join-string.

=method keyed

    my $array = [1..5];
    $array->keyed('a'..'d'); # {a=>1,b=>2,c=>3,d=>4}

The keyed method returns a hash reference where the arguments become the keys,
and the elements of the subject become the values.

=method keys

    my $array = ['a'..'d'];
    $array->keys; # [0,1,2,3]

The keys method returns an array reference consisting of the indicies of the
subject.

=method last

    my $array = [1..5];
    $array->last; # 5

The last method returns the value of the last element in the subject.

=method length

    my $array = [1..5];
    $array->length; # 5

The length method returns the number of elements in the subject.

=method list

    my $array = [1..5];
    $array->list; # (1,2,3,4,5)

The list method returns the elements in the subject as a list.

=method map

    my $array = [1..5];
    $array->map(sub{
        shift + 1
    });

    # [2,3,4,5,6]

The map method iterates over each element in the subject, executing the
code reference supplied in the argument, passing the routine the value at the
current position in the loop and returning a new array reference containing
the elements for which the argument returns a value or non-empty list.

=method max

    my $array = [8,9,1,2,3,4,5];
    $array->max; # 9

The max method returns the element in the subject with the highest numerical
value. All non-numerical element are skipped during the evaluation process.

=method min

    my $array = [8,9,1,2,3,4,5];
    $array->min; # 1

The min method returns the element in the subject with the lowest numerical
value. All non-numerical element are skipped during the evaluation process.

=method none

    my $array = [2..5];
    $array->none <= 1; # 1; true
    $array->none <= 2; # 0; false

The none method returns true if none of the elements in the subject meet the
criteria set by the operand and rvalue.

=method nsort

    my $array = [5,4,3,2,1];
    $array->nsort; # [1,2,3,4,5]

The nsort method returns an array reference containing the values in the subject
sorted numerically.

=method one

    my $array = [2..5];
    $array->one == 5; # 1; true
    $array->one == 6; # 0; false

The one method returns true if only one of the elements in the subject meet the
criteria set by the operand and rvalue.

=method pairs

    my $array = [1..5];
    $array->pairs; # [[0,1],[1,2],[2,3],[3,4],[4,5]]

The pairs method is an alias to the pairs_array method.

=method pairs_array

    my $array = [1..5];
    $array->pairs_array; # [[0,1],[1,2],[2,3],[3,4],[4,5]]

The pairs_array method returns an array reference consisting of array references
where each sub array reference has two elements corresponding to the index and
value of each element in the subject.

=method pairs_hash

    my $array = [1..5];
    $array->pairs_hash; # {0=>1,1=>2,2=>3,3=>4,4=>5}

The pairs_hash method returns a hash reference where each key and value pairs
corresponds to the index and value of each element in the subject.

=method pop

    my $array = [1..5];
    $array->pop; # 5

The pop method returns the last element of the subject shortening it by one. Note,
this method modifies the subject.

=method push

    my $array = [1..5];
    $array->push(6,7,8); # [1,2,3,4,5,6,7,8]

The push method appends the subject by pushing the agruments onto it and returns
itself. Note, this method modifies the subject.

=method random

    my $array = [1..5];
    $array->random; # 4

The random method returns a random element from the subject.

=method reverse

    my $array = [1..5];
    $array->reverse; # [5,4,3,2,1]

The reverse method returns an array reference containing the elements in the
subject in reverse order.

=method rotate

    my $array = [1..5];
    $array->rotate; # [2,3,4,5,1]
    $array->rotate; # [3,4,5,1,2]
    $array->rotate; # [4,5,1,2,3]

The rotate method rotates the elements in the subject such that first elements becomes the last element and the second element becomes the first element each time this method is called. Note, this method modifies the subject.

=method rnsort

    my $array = [5,4,3,2,1];
    $array->rnsort; # [5,4,3,2,1]

The rnsort method returns an array reference containing the values in the
subject sorted numerically in reverse.

=method rsort

    my $array = ['a'..'d'];
    $array->rsort; # ['d','c','b','a']

The rsort method returns an array reference containing the values in the subject
sorted alphanumerically in reverse.

=method set

    my $array = [1..5];
    $array->set(4,6); # [1,2,3,4,6]

The set method returns the value of the element in the subject at the index
specified by the argument after updating it to the value of the second argument.

=method shift

    my $array = [1..5];
    $array->shift; # 1

The shift method returns the first element of the subject shortening it by one.
Note, this method modifies the subject.

=method size

    my $array = [1..5];
    $array->size; # 5

The size method is an alias to the length method.

=method slice

    my $array = [1..5];
    $array->slice(2,4); # [3,5]

The slice method returns an array reference containing the elements in the
subject at the index(es) specified in the arguments.

=method sort

    my $array = ['d','c','b','a'];
    $array->sort; # ['a','b','c','d']

The sort method returns an array reference containing the values in the subject
sorted alphanumerically.

=method sum

    my $array = [1..5];
    $array->sum; # 15

The sum method returns the sum of all values for all numerical elements in the
subject. All non-numerical element are skipped during the evaluation process.

=method tail

    my $array = [1..5];
    $array->tail; # [2,3,4,5]

The tail method returns an array reference containing the second through the
last elements in the subject omitting the first.

=method unique

    my $array = [1,1,1,1,2,3,1];
    $array->unique; # [1,2,3]

The unique method returns an array reference consisting of the unique elements
in the subject.

=method unshift

    my $array = [1..5];
    $array->unshift(-2,-1,0); # [-2,-1,0,1,2,3,4,5]

The unshift method prepends the subject by pushing the agruments onto it and
returns itself. Note, this method modifies the subject.

=method values

    my $array = [1..5];
    $array->values; # [1,2,3,4,5]

The values method returns an array reference consisting of the elements in the
subject. This method essentially copies the content of the subject into a new
container.

=head1 SEE ALSO

L<Bubblegum::Object::Array>, L<Bubblegum::Object::Code>,
L<Bubblegum::Object::Hash>, L<Bubblegum::Object::Instance>,
L<Bubblegum::Object::Integer>, L<Bubblegum::Object::Number>,
L<Bubblegum::Object::Scalar>, L<Bubblegum::Object::String>,
L<Bubblegum::Object::Undef>, L<Bubblegum::Object::Universal>,

=cut
