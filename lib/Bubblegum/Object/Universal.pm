# ABSTRACT: Common Methods for Operating on Defined Values
package Bubblegum::Object::Universal;

use 5.10.0;

use Bubblegum::Namespace;
use Class::Load ();

our @ISA = (); # non-object

# VERSION

sub digest {
    my $self  = CORE::shift;
    return wrapper($self, 'Digest');
}

sub dumper {
    my $self  = CORE::shift;
    return wrapper($self, 'Dumper');
}

sub encoder {
    my $self  = CORE::shift;
    return wrapper($self, 'Encoder');
}

sub instance {
    my $self  = CORE::shift;
    my $class = $$Bubblegum::Namespace::ExtendedTypes{'INSTANCE'};
    return Class::Load::load_class($class)->new(data => $self);
}

sub json {
    my $self  = CORE::shift;
    return wrapper($self, 'Json');
}

sub wrapper {
    my $self  = CORE::shift;
    my $class = CORE::shift;
    my $wrapper = $$Bubblegum::Namespace::ExtendedTypes{'WRAPPER'};
    return Class::Load::load_class(join('::', $wrapper, $class))->new(data => $self);
}

sub yaml {
    my $self  = CORE::shift;
    return wrapper($self, 'Yaml');
}

1;

=encoding utf8

=head1 SYNOPSIS

    use Bubblegum;

    my $thing = 0;
    $thing->instance; # bless({'data' => 0}, 'Bubblegum::Object::Instance')

=head1 DESCRIPTION

Universal methods work on variables whose data meets the criteria for being
defined. It is not necessary to use this module as it is loaded automatically by
the L<Bubblegum> class.

=method digest

    my $thing = '...';
    $thing->digest; # bless({'data' => '...'}, 'Bubblegum::Object::Digest')

    my $data = $thing->digest->data;

The digest method blesses the subject into the wrapper class,
L<Bubblegum::Object::Digest>, and returns an instance. Please see
L<Bubblegum::Object::Digest> for more information.

=method dumper

    my $thing = '...';
    $thing->dumper; # bless({'data' => '...'}, 'Bubblegum::Object::Dumper')

    my $data = $thing->dumper->data;

The dumper method blesses the subject into the wrapper class,
L<Bubblegum::Object::Dumper>, and returns an instance. Please see
L<Bubblegum::Object::Dumper> for more information.

=method encoder

    my $thing = '...';
    $thing->encoder; # bless({'data' => '...'}, 'Bubblegum::Object::Encoder')

    my $data = $thing->encoder->data;

The encoder method blesses the subject into the wrapper class,
L<Bubblegum::Object::Encoder>, and returns an instance. Please see
L<Bubblegum::Object::Encoder> for more information.

=method instance

    my $thing = 0;
    $thing->instance; # bless({'data' => 0}, 'Bubblegum::Object::Instance')

    my $data = $thing->instance->data;

The instance method blesses the subject into a generic container class,
Bubblegum::Object::Instance, and returns an instance. Please see
L<Bubblegum::Object::Instance> for more information.

=method json

    my $thing = '...';
    $thing->json; # bless({'data' => '...'}, 'Bubblegum::Object::Json')

    my $data = $thing->json->data;

The json method blesses the subject into the wrapper class,
L<Bubblegum::Object::Json>, and returns an instance. Please see
L<Bubblegum::Object::Json> for more information.

=method wrapper

    my $thing = [1,0];
    $thing->wrapper('json');
    $thing->json; # bless({'data' => [1,0]}, 'Bubblegum::Wrapper::Json')

    my $json = $thing->json->encode;

The wrapper method blesses the subject into a Bubblegum wrapper, a container
class, which exists as an extension to the core data type methods, and returns
an instance. Please see any one of the core Bubblegum wrappers, e.g.,
L<Bubblegum::Wrapper::Digest>, L<Bubblegum::Wrapper::Dumper>,
L<Bubblegum::Wrapper::Encoder>, L<Bubblegum::Wrapper::Json> or
L<Bubblegum::Wrapper::Yaml>.

=method yaml

    my $thing = '...';
    $thing->yaml; # bless({'data' => '...'}, 'Bubblegum::Object::Yaml')

    my $data = $thing->yaml->data;

The yaml method blesses the subject into the wrapper class,
L<Bubblegum::Object::Yaml>, and returns an instance. Please see
L<Bubblegum::Object::Yaml> for more information.

=head2 Type Validation

All data type objects have access to type checking and validation methods which
can be call to help ensure data integrity. The following is a list of standard
type checking and validation methods whose routines map to those corresponding
in the L<Types::Standard> library.

=method asa_aref

    my $thing = undef;
    $thing->asa_aref;

The aref method asserts that the caller is an array reference. If the caller is
not an array reference, the program will die.

=method asa_arrayref

    my $thing = undef;
    $thing->asa_arrayref;

The arrayref method asserts that the caller is an array reference. If the caller
is not an array reference, the program will die.

=method asa_bool

    my $thing = undef;
    $thing->asa_bool;

The bool method asserts that the caller is a boolean value. If the caller is not
a boolean value, the program will die.

=method asa_boolean

    my $thing = undef;
    $thing->asa_boolean;

The boolean method asserts that the caller is a boolean value. If the caller is
not a boolean value, the program will die.

=method asa_class

    my $thing = undef;
    $thing->asa_class;

The class method asserts that the caller is a class name. If the caller is not a
class name, the program will die.

=method asa_classname

    my $thing = undef;
    $thing->asa_classname;

The classname method asserts that the caller is a class name. If the caller is
not a class name, the program will die.

=method asa_coderef

    my $thing = undef;
    $thing->asa_coderef;

The coderef method asserts that the caller is a code reference. If the caller is
not a code reference, the program will die.

=method asa_cref

    my $thing = undef;
    $thing->asa_cref;

The cref method asserts that the caller is a code reference. If the caller is
not a code reference, the program will die.

=method asa_def

    my $thing = undef;
    $thing->asa_def;

The def method asserts that the caller is a defined value. If the caller is not
a defined value, the program will die.

=method asa_defined

    my $thing = undef;
    $thing->asa_defined;

The defined method asserts that the caller is a defined value. If the caller is
not a defined value, the program will die.

=method asa_fh

    my $thing = undef;
    $thing->asa_fh;

The fh method asserts that the caller is a file handle. If the caller is not a
file handle, the program will die.

=method asa_filehandle

    my $thing = undef;
    $thing->asa_filehandle;

The filehandle method asserts that the caller is a file handle. If the caller is
not a file handle, the program will die.

=method asa_glob

    my $thing = undef;
    $thing->asa_glob;

The glob method asserts that the caller is a glob reference. If the caller is
not a glob reference, the program will die.

=method asa_globref

    my $thing = undef;
    $thing->asa_globref;

The globref method asserts that the caller is a glob reference. If the caller is
not a glob reference, the program will die.

=method asa_hashref

    my $thing = undef;
    $thing->asa_hashref;

The hashref method asserts that the caller is a hash reference. If the caller is
not a hash reference, the program will die.

=method asa_href

    my $thing = undef;
    $thing->asa_href;

The href method asserts that the caller is a hash reference. If the caller is
not a hash reference, the program will die.

=method asa_int

    my $thing = undef;
    $thing->asa_int;

The int method asserts that the caller is an integer. If the caller is not an
integer, the program will die.

=method asa_integer

    my $thing = undef;
    $thing->asa_integer;

The integer method asserts that the caller is an integer. If the caller is not
an integer, the program will die.

=method asa_num

    my $thing = undef;
    $thing->asa_num;

The num method asserts that the caller is a number. If the caller is not a
number, the program will die.

=method asa_number

    my $thing = undef;
    $thing->asa_number;

The number method asserts that the caller is a number. If the caller is not a
number, the program will die.

=method asa_obj

    my $thing = undef;
    $thing->asa_obj;

The obj method asserts that the caller is an object. If the caller is not an
object, the program will die.

=method asa_object

    my $thing = undef;
    $thing->asa_object;

The object method asserts that the caller is an object. If the caller is not an
object, the program will die.

=method asa_ref

    my $thing = undef;
    $thing->asa_ref;

The ref method asserts that the caller is a reference. If the caller is not a
reference, the program will die.

=method asa_reference

    my $thing = undef;
    $thing->asa_reference;

The reference method asserts that the caller is a reference. If the caller is
not a reference, the program will die.

=method asa_regexpref

    my $thing = undef;
    $thing->asa_regexpref;

The regexpref method asserts that the caller is a regular expression reference.
If the caller is not a regular expression reference, the program will die.

=method asa_rref

    my $thing = undef;
    $thing->asa_rref;

The rref method asserts that the caller is a regular expression reference. If
the caller is not a regular expression reference, the program will die.

=method asa_scalarref

    my $thing = undef;
    $thing->asa_scalarref;

The scalarref method asserts that the caller is a scalar reference. If the
caller is not a scalar reference, the program will die.

=method asa_sref

    my $thing = undef;
    $thing->asa_sref;

The sref method asserts that the caller is a scalar reference. If the caller is
not a scalar reference, the program will die.

=method asa_str

    my $thing = undef;
    $thing->asa_str;

The str method asserts that the caller is a string. If the caller is not a
string, the program will die.

=method asa_string

    my $thing = undef;
    $thing->asa_string;

The string method asserts that the caller is a string. If the caller is not a
string, the program will die.

=method asa_nil

    my $thing = undef;
    $thing->asa_nil;

The nil method asserts that the caller is an undefined value. If the caller is
not an undefined value, the program will die.

=method asa_null

    my $thing = undef;
    $thing->asa_null;

The null method asserts that the caller is an undefined value. If the caller is
not an undefined value, the program will die.

=method asa_undef

    my $thing = undef;
    $thing->asa_undef;

The undef method asserts that the caller is an undefined value. If the caller is
not an undefined value, the program will die.

=method asa_undefined

    my $thing = undef;
    $thing->asa_undefined;

The undefined method asserts that the caller is an undefined value. If the
caller is not an undefined value, the program will die.

=method asa_val

    my $thing = undef;
    $thing->asa_val;

The val method asserts that the caller is a value. If the caller is not a value,
the program will die.

=method asa_value

    my $thing = undef;
    $thing->asa_value;

The value method asserts that the caller is a value. If the caller is not a
value, the program will die.

=method isa_aref

    my $thing = undef;
    $thing->isa_aref;

The aref method checks that the caller is an array reference. If the caller is
not an array reference, the method will return false.

=method isa_arrayref

    my $thing = undef;
    $thing->isa_arrayref;

The arrayref method checks that the caller is an array reference. If the caller
is not an array reference, the method will return false.

=method isa_bool

    my $thing = undef;
    $thing->isa_bool;

The bool method checks that the caller is a boolean value. If the caller is not
a boolean value, the method will return false.

=method isa_boolean

    my $thing = undef;
    $thing->isa_boolean;

The boolean method checks that the caller is a boolean value. If the caller is
not a boolean value, the method will return false.

=method isa_class

    my $thing = undef;
    $thing->isa_class;

The class method checks that the caller is a class name. If the caller is not a
class name, the method will return false.

=method isa_classname

    my $thing = undef;
    $thing->isa_classname;

The classname method checks that the caller is a class name. If the caller is
not a class name, the method will return false.

=method isa_coderef

    my $thing = undef;
    $thing->isa_coderef;

The coderef method checks that the caller is a code reference. If the caller is
not a code reference, the method will return false.

=method isa_cref

    my $thing = undef;
    $thing->isa_cref;

The cref method checks that the caller is a code reference. If the caller is not
a code reference, the method will return false.

=method isa_def

    my $thing = undef;
    $thing->isa_def;

The def method checks that the caller is a defined value. If the caller is not a
defined value, the method will return false.

=method isa_defined

    my $thing = undef;
    $thing->isa_defined;

The defined method checks that the caller is a defined value. If the caller is
not a defined value, the method will return false.

=method isa_fh

    my $thing = undef;
    $thing->isa_fh;

The fh method checks that the caller is a file handle. If the caller is not a
file handle, the method will return false.

=method isa_filehandle

    my $thing = undef;
    $thing->isa_filehandle;

The filehandle method checks that the caller is a file handle. If the caller is
not a file handle, the method will return false.

=method isa_glob

    my $thing = undef;
    $thing->isa_glob;

The glob method checks that the caller is a glob reference. If the caller is not
a glob reference, the method will return false.

=method isa_globref

    my $thing = undef;
    $thing->isa_globref;

The globref method checks that the caller is a glob reference. If the caller is
not a glob reference, the method will return false.

=method isa_hashref

    my $thing = undef;
    $thing->isa_hashref;

The hashref method checks that the caller is a hash reference. If the caller is
not a hash reference, the method will return false.

=method isa_href

    my $thing = undef;
    $thing->isa_href;

The href method checks that the caller is a hash reference. If the caller is not
a hash reference, the method will return false.

=method isa_int

    my $thing = undef;
    $thing->isa_int;

The int method checks that the caller is an integer. If the caller is not an
integer, the method will return false.

=method isa_integer

    my $thing = undef;
    $thing->isa_integer;

The integer method checks that the caller is an integer. If the caller is not an
integer, the method will return false.

=method isa_num

    my $thing = undef;
    $thing->isa_num;

The num method checks that the caller is a number. If the caller is not a
number, the method will return false.

=method isa_number

    my $thing = undef;
    $thing->isa_number;

The number method checks that the caller is a number. If the caller is not a
number, the method will return false.

=method isa_obj

    my $thing = undef;
    $thing->isa_obj;

The obj method checks that the caller is an object. If the caller is not an
object, the method will return false.

=method isa_object

    my $thing = undef;
    $thing->isa_object;

The object method checks that the caller is an object. If the caller is not an
object, the method will return false.

=method isa_ref

    my $thing = undef;
    $thing->isa_ref;

The ref method checks that the caller is a reference. If the caller is not a
reference, the method will return false.

=method isa_reference

    my $thing = undef;
    $thing->isa_reference;

The reference method checks that the caller is a reference. If the caller is not
a reference, the method will return false.

=method isa_regexpref

    my $thing = undef;
    $thing->isa_regexpref;

The regexpref method checks that the caller is a regular expression reference.
If the caller is not a regular expression reference, the method will return
false.

=method isa_rref

    my $thing = undef;
    $thing->isa_rref;

The rref method checks that the caller is a regular expression reference. If the
caller is not a regular expression reference, the method will return false.

=method isa_scalarref

    my $thing = undef;
    $thing->isa_scalarref;

The scalarref method checks that the caller is a scalar reference. If the caller
is not a scalar reference, the method will return false.

=method isa_sref

    my $thing = undef;
    $thing->isa_sref;

The sref method checks that the caller is a scalar reference. If the caller is
not a scalar reference, the method will return false.

=method isa_str

    my $thing = undef;
    $thing->isa_str;

The str method checks that the caller is a string. If the caller is not a
string, the method will return false.

=method isa_string

    my $thing = undef;
    $thing->isa_string;

The string method checks that the caller is a string. If the caller is not a
string, the method will return false.

=method isa_nil

    my $thing = undef;
    $thing->isa_nil;

The nil method checks that the caller is an undefined value. If the caller is
not an undefined value, the method will return false.

=method isa_null

    my $thing = undef;
    $thing->isa_null;

The null method checks that the caller is an undefined value. If the caller is
not an undefined value, the method will return false.

=method isa_undef

    my $thing = undef;
    $thing->isa_undef;

The undef method checks that the caller is an undefined value. If the caller is
not an undefined value, the method will return false.

=method isa_undefined

    my $thing = undef;
    $thing->isa_undefined;

The undefined method checks that the caller is an undefined value. If the caller
is not an undefined value, the method will return false.

=method isa_val

    my $thing = undef;
    $thing->isa_val;

The val method checks that the caller is a value. If the caller is not a value,
the method will return false.

=method isa_value

    my $thing = undef;
    $thing->isa_value;

The value method checks that the caller is a value. If the caller is not a
value, the method will return false.

=head1 SEE ALSO

L<Bubblegum::Object::Array>, L<Bubblegum::Object::Code>,
L<Bubblegum::Object::Hash>, L<Bubblegum::Object::Instance>,
L<Bubblegum::Object::Integer>, L<Bubblegum::Object::Number>,
L<Bubblegum::Object::Scalar>, L<Bubblegum::Object::String>,
L<Bubblegum::Object::Undef>, L<Bubblegum::Object::Universal>,

=cut
