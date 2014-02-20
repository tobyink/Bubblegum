# ABSTRACT: Common Helper Functions for Structuring Applications
package Bubblegum::Syntax;

use 5.10.0;
use utf8::all;
use strict;
use warnings;
use Bubblegum::Exception;
use Try::Tiny;
use Hash::Merge::Simple 'merge';

use Cwd ();
use Class::Load ();
use Data::Dumper ();
use File::HomeDir ();
use File::Find::Rule ();
use File::Spec ();
use File::Which ();
use DateTime::Tiny ();
use Path::Tiny ();
use Time::Format ();
use Time::ParseDate ();
use Type::Params ();
use Types::Standard ();

use base 'Exporter::Tiny';

# VERSION

=head1 SYNOPSIS

    package Server;

    use Bubblegum::Class;
    use Bubblegum::Syntax -attr, -typesof;

    has typeof_href, 'config';

    package main;

    use Bubblegum;
    use Bubblegum::Syntax -utils;

    my $data = file('./config')->slurp;
    my $config = $data->yaml->decode if isa_str $data;

    my $server = Server->new(config =>
        $config->lookup('node1.webserver'));

=head1 DESCRIPTION

Bubblegum::Syntax is a sugar layer for L<Bubblegum> applications with a focus on
minimalism and data integrity.

=head1 EXPORTS

By default, no functions are exported when using this package, all functionality
desired will need to be explicitly requested, and because many functions belong
to a particular group of functions there are export tags which can be used to
export sets of functions by group name. Any function can also be exported
individually. The following are a list of functions and groups currently
available:

=head2 -attr

The attr export group currently exports a single functions which overrides the
C<has> accessor maker in the calling class and implements a more flexible
interface specification. If the C<has> function does not exist in the caller's
namespace then override will be aborted, otherwise, the C<has> function will now
support the following:

    has 'attr1';

is the equivalent of:

    has 'attr1' => (
        is => 'ro',
    );

and if type validators are exported via C<-typesof>:

    use Bubblegum::Syntax -typesof;

    has typeof_obj, 'attr2';

is the equivalent of:

    has 'attr2' => (
        is  => 'ro',
        isa => typeof_obj,
    );

and/or including a default value, for example:

    use Bubblegum::Syntax -typesof;

    has 'attr1' => sub {
        # set default for attr1
    };

    has typeof_obj, 'attr2' => sub {
        # set default for attr2
    };

is the equivalent of:

    has 'attr1' => (
        is      => 'ro',
        lazy    => 1,
        default => sub {}
    );

    has 'attr2' => (
        is      => 'ro',
        isa     => typeof_obj,
        lazy    => 1,
        default => sub {}
    );

=head2 -isas

The isas export group exports all functions which have the C<isa_> prefix. These
functions take a single argument and perform non-fatal type checking and return
true or false. The follow is a list of functions exported by this group:

=over 4

=item *

isa_aref

=item *

isa_arrayref

=item *

isa_bool

=item *

isa_boolean

=item *

isa_class

=item *

isa_classname

=item *

isa_cref

=item *

isa_coderef

=item *

isa_def

=item *

isa_defined

=item *

isa_fh

=item *

isa_filehandle

=item *

isa_glob

=item *

isa_globref

=item *

isa_href

=item *

isa_hashref

=item *

isa_int

=item *

isa_integer

=item *

isa_num

=item *

isa_number

=item *

isa_obj

=item *

isa_object

=item *

isa_ref

=item *

isa_reference

=item *

isa_rref

=item *

isa_regexpref

=item *

isa_sref

=item *

isa_scalarref

=item *

isa_str

=item *

isa_string

=item *

isa_nil

=item *

isa_null

=item *

isa_undef

=item *

isa_undefined

=back

=head2 -nots

The nots export group exports all functions which have the C<not_> prefix. These
functions take a single argument and perform non-fatal negated type checking and
return true or false. The follow is a list of functions exported by this group:

=over 4

=item *

not_aref

=item *

not_arrayref

=item *

not_bool

=item *

not_boolean

=item *

not_class

=item *

not_classname

=item *

not_cref

=item *

not_coderef

=item *

not_def

=item *

not_defined

=item *

not_fh

=item *

not_filehandle

=item *

not_glob

=item *

not_globref

=item *

not_href

=item *

not_hashref

=item *

not_int

=item *

not_integer

=item *

not_num

=item *

not_number

=item *

not_obj

=item *

not_object

=item *

not_ref

=item *

not_reference

=item *

not_rref

=item *

not_regexpref

=item *

not_sref

=item *

not_scalarref

=item *

not_str

=item *

not_string

=item *

not_nil

=item *

not_null

=item *

not_undef

=item *

not_undefined

=back

=head2 -types

The types export group exports all functions which have the C<type_> prefix.
These functions take a single argument/expression and perform fatal type
checking operation returning the argument/expression if successful. The follow
is a list of functions exported by this group:

=over 4

=item *

type_aref

=item *

type_arrayref

=item *

type_bool

=item *

type_boolean

=item *

type_class

=item *

type_classname

=item *

type_cref

=item *

type_coderef

=item *

type_def

=item *

type_defined

=item *

type_fh

=item *

type_filehandle

=item *

type_glob

=item *

type_globref

=item *

type_href

=item *

type_hashref

=item *

type_int

=item *

type_integer

=item *

type_num

=item *

type_number

=item *

type_obj

=item *

type_object

=item *

type_ref

=item *

type_reference

=item *

type_rref

=item *

type_regexpref

=item *

type_sref

=item *

type_scalarref

=item *

type_str

=item *

type_string

=item *

type_nil

=item *

type_null

=item *

type_undef

=item *

type_undefined

=back

=head2 -typesof

The typesof export group exports all functions which have the C<typeof_> prefix.
These functions take no argument and return a type-validation code-routine to be
used with your object-system of choice. The follow is a list of functions
exported by this group:

=over 4

=item *

typeof_aref

=item *

typeof_arrayref

=item *

typeof_bool

=item *

typeof_boolean

=item *

typeof_class

=item *

typeof_classname

=item *

typeof_cref

=item *

typeof_coderef

=item *

typeof_def

=item *

typeof_defined

=item *

typeof_fh

=item *

typeof_filehandle

=item *

typeof_glob

=item *

typeof_globref

=item *

typeof_href

=item *

typeof_hashref

=item *

typeof_int

=item *

typeof_integer

=item *

typeof_num

=item *

typeof_number

=item *

typeof_obj

=item *

typeof_object

=item *

typeof_ref

=item *

typeof_reference

=item *

typeof_rref

=item *

typeof_regexpref

=item *

typeof_sref

=item *

typeof_scalarref

=item *

typeof_str

=item *

typeof_string

=item *

typeof_nil

=item *

typeof_null

=item *

typeof_undef

=item *

typeof_undefined

=back

=head2 -utils

The utils export group exports all miscellaneous utility functions, e.g. file,
path, date, etc. Many of these functions are wrappers around standard CPAN
modules. The follow is a list of functions exported by this group:

=over 4

=item *

cwd

=item *

date

=item *

date_epoch

=item *

date_format

=item *

dump

=item *

file

=item *

find

=item *

home

=item *

merge

=item *

load

=item *

path

=item *

quote

=item *

raise

=item *

script

=item *

unquote

=item *

user

=item *

user_info

=item *

which

=back

=cut

our $EXTS = {
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
};

my %TYPES = (
    ArrayRef   => ['aref', 'arrayref'],
    Bool       => ['bool', 'boolean'],
    ClassName  => ['class', 'classname'],
    CodeRef    => ['cref', 'coderef'],
    Defined    => ['def', 'defined'],
    FileHandle => ['fh', 'filehandle'],
    GlobRef    => ['glob', 'globref'],
    HashRef    => ['href', 'hashref'],
    Int        => ['int', 'integer'],
    Num        => ['num', 'number'],
    Object     => ['obj', 'object'],
    Ref        => ['ref', 'reference'],
    RegexpRef  => ['rref', 'regexpref'],
    ScalarRef  => ['sref', 'scalarref'],
    Str        => ['str', 'string'],
    Undef      => ['nil', 'null', 'undef', 'undefined'],
    Value      => ['val', 'value'],
);

our @EXPORT_OK = qw(
    cwd
    date
    date_epoch
    date_format
    dump
    file
    find
    here
    home
    merge
    load
    path
    quote
    raise
    script
    unquote
    user
    user_info
    which
);
our %EXPORT_TAGS = (
    attr => sub {
        my $args    = pop;
        my $target  = $args->{into};
        my $builder = $target->can('has') or return;
        no strict 'refs';
        no warnings 'redefine';
        *{"${target}::has"} = sub {
            my $type    = shift if isa_coderef($_[0]);
            my $names   = isa_aref($_[0]) ? $_[0] : [$_[0]];
            my $default = $_[1] if isa_coderef($_[1]);
            if ((@_ == 1 xor @_ == 2) && $names) {
                for my $name (@{$names}) {
                    my %props = (is => 'ro');
                    $props{isa} = $type if $type;
                    $props{lazy} = 1 if $default;
                    $props{default} = $default if $default;
                    $builder->($name => (%props));
                }
            }
            else {
                $builder->(@_);
            }
            return;
        };
        return;
    },
    utils => sub {
        return qw(
            cwd
            date
            date_epoch
            date_format
            dump
            file
            find
            here
            home
            merge
            load
            path
            quote
            raise
            script
            unquote
            user
            user_info
            which
        )
    }
);
{
    no strict 'refs';
    my $package  = __PACKAGE__;
    my $compiler = Type::Params->can('compile');
    while (my($class, $names) = each %TYPES) {
        my $validator  = Types::Standard->can($class);
        my $validation = $compiler->($validator->());
        for my $name (@{$names}) {
            # generate isas
            {
                my $name = "isa_$name";
                push @EXPORT_OK, $name;
                push @{$EXPORT_TAGS{isas}}, $name;
                *{"${package}::${name}"} = sub (;*) {
                    my $data = shift;
                    return eval { $validation->($data) } || 0;
                };
            }
            # generate nots
            {
                my $name = "not_$name";
                push @EXPORT_OK, $name;
                push @{$EXPORT_TAGS{nots}}, $name;
                *{"${package}::${name}"} = sub (;*) {
                    my $data = shift;
                    return ! eval { $validation->($data) } || 0;
                };
            }
            # generate types
            {
                my $name = "type_$name";
                push @EXPORT_OK, $name;
                push @{$EXPORT_TAGS{types}}, $name;
                *{"${package}::${name}"} = sub (;*) {
                    my $data = shift;
                    my $context = [caller(0)];
                    try {
                        $validation->($data);
                        return $data;
                    } catch {
                        my $error = $_[0];
                        $error->{context}{package} = $context->[0];
                        $error->{context}{file}    = $context->[1];
                        $error->{context}{line}    = $context->[2];
                        die $error;
                    };
                };
            }
            # generate typeofs
            {
                my $name = "typeof_$name";
                push @EXPORT_OK, $name;
                push @{$EXPORT_TAGS{typesof}}, $name;
                *{"${package}::${name}"} = sub () {
                    return $validation;
                };
            }
        }
    }
}

=function cwd

The cwd function returns a L<Path::Tiny> instance for operating on the current
working directory.

    my $dir = cwd;
    my @more = $dir->children;

=cut

sub cwd {
    return Path::Tiny->cwd;
}

=function date

The date function returns a L<DateTime::Tiny> instance from an epoch or common
date phrase, e.g. yesterday.

    my $date = date 'this friday';

=cut

sub date {
    my $input = shift || 'now';
    my $epoch = date_epoch($input, @_);
    my $date  = date_format($epoch) or return;
    DateTime::Tiny->from_string($date);
}

=function date_epoch

The date_epoch function returns an epoch string from a common date phrase, e.g.
yesterday.

    my $date = date 'next friday';

=cut

sub date_epoch {
    my $input = shift || 'now';
    my $epoch = [Time::ParseDate::parsedate $input, @_];
    return $epoch->[0] or undef;
}

=function date_format

The date_format function returns a formatted date string from an epoch string
and a L<Time::Format> template.

    my $date = date_format time;

=cut

sub date_format {
    my $epoch  = shift or return;
    my $format = shift || 'yyyy-mm-ddThh:mm:ss';
    # my $format = shift || 'yyyy-mm{on}-dd hh:mm{in}:ss tz'; # not atm
    return Time::Format::time_format $format, $epoch;
}

=function dump

The dump function returns a representation of a Perl data structure.

    my $class = bless {}, 'main';
    say dump $class;

=cut

sub dump {
    return Data::Dumper->new([shift])
        ->Indent(1)->Sortkeys(1)->Terse(1)->Dump
}

=function file

The file function returns a L<Path::Tiny> instance for operating on files.

    my $file  = file './customers.json';
    my $lines = $file->slurp;

=cut

sub file {
    goto &path;
}

=function find

The find function traverses a directory and returns an arrayref of L<Path::Tiny>
objects matching the specified criteria.

    my $texts = find './documents', '*.txt';

=cut

sub find {
    my $spec = !$#_ ? '*.*' : pop;
    my $path ||= path(@_);
    return [ map { path($_) }
        File::Find::Rule->file()->name($spec)->in($path) ];
}

=function here

The here function returns a L<Path::Tiny> instance for operating on the directory
of the file the function is called from.

    my $dir = here;
    my @more = $dir->children;

=cut

sub here {
    return path(
        File::Spec->rel2abs(
            join '', (File::Spec->splitpath((caller 1)[1]))[0,1]
        )
    );
}

=function home

The home function returns a L<Path::Tiny> instance for operating on the current
user's home directory.

    my $dir = home;
    my @more = $dir->children;

=cut

sub home {
    my $user = $ENV{USER} // user();
    my $func = $user ? 'users_home' : 'my_home';
    return eval { path(File::HomeDir->can($func)->($user)) };
}

=function load

The load function uses L<Class::Load> to require modules at runtime.

    my $class = load 'Test::Automata';

=cut

sub load {
    return Class::Load::load_class(@_);
}

=function path

The path function returns a L<Path::Tiny> instance for operating on the
directory specified.

    my $dir = path '/';
    my @more = $dir->children;

=cut

sub path {
    return Path::Tiny::path(@_);
}

=function quote

The quote function escapes double-quoted strings within the string.

    my $string = quote '"Ins\'t it a wonderful day"';

=cut

sub quote {
    my $string = shift;
    return unless defined $string;
    $string =~ s/(["\\])/\\$1/g;
    return qq{"$string"};
}

=function raise

The raise function uses L<Bubblegum::Exception> to throw a catchable exception.
The raise function can also store arbitrary data that can be accessed by the
trap.

    raise 'business object not saved' => { obj => $business }
        if ! $business->id;

=cut

sub raise {
    my $class = 'Bubblegum::Exception';
    @_ = ($class, message => shift, data => shift // {});
    goto $class->can('throw');
}

=function script

The script function returns a L<Path::Tiny> instance for operating on the script
being executed.

=cut

sub script {
    return file($0);
}

=function unquote

The unquote function unescapes double-quoted strings within the string.

    my $string = unquote '\"Ins\'t it a wonderful day\"';

=cut

sub unquote {
    my $string = shift;
    return unless defined $string;
    return $string unless $string =~ s/^"(.*)"$/$1/g;
    $string =~ s/\\\\/\\/g;
    $string =~ s/\\"/"/g;
    return $string;
}

=function user

The user function returns the current user's username.

    my $nick = user;

=cut

sub user {
    return user_info()->[0];
}

=function user_info

The user_info function returns an array reference of user information. This
function is not currently portable and only works on *nix systems.

    my $info = user_info;

=cut

sub user_info {
    return [eval '(getpwuid $>)'];
}

=function which

The which function use L<File::Which> to return a L<Path::Tiny> instance for
operating on the located executable program.

    my $mailer = which 'sendmail';

=cut

sub which {
    return path(File::Which::which(@_));
}

1;
