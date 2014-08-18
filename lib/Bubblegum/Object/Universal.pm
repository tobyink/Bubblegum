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

=cut

=method instance

    my $thing = 0;
    $thing->instance; # bless({'data' => 0}, 'Bubblegum::Object::Instance')

    my $data = $thing->instance->data; # 0

The instance method blesses the subject into a generic container class,
Bubblegum::Object::Instance, and returns an instance. Please see
L<Bubblegum::Object::Instance> for more information.

=cut

=method wrapper

    my $thing = [1,0];
    $thing->wrapper('json'); # same as ...
    $thing->json; # bless({'data' => [1,0]}, 'Bubblegum::Wrapper::Json')

    my $json = $thing->json->encode; # [1,0]

The wrapper method blesses the subject into a Bubblegum wrapper, a container
class, which exists as an extension to the core data type methods, and returns
an instance. Please see any one of the core Bubblegum wrappers, e.g.,
L<Bubblegum::Wrapper::Digest>, L<Bubblegum::Wrapper::Dumper>,
L<Bubblegum::Wrapper::Encoder>, L<Bubblegum::Wrapper::Json> or
L<Bubblegum::Wrapper::Yaml>.

=head1 SEE ALSO

L<Bubblegum::Object::Array>, L<Bubblegum::Object::Code>,
L<Bubblegum::Object::Hash>, L<Bubblegum::Object::Instance>,
L<Bubblegum::Object::Integer>, L<Bubblegum::Object::Number>,
L<Bubblegum::Object::Scalar>, L<Bubblegum::Object::String>,
L<Bubblegum::Object::Undef>, L<Bubblegum::Object::Universal>,

=cut
