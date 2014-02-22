use Test::More;
use Bubblegum::Syntax;

my @typelib = qw(
    aref arrayref bool boolean class classname cref coderef def defined fh
    filehandle glob globref href hashref int integer num number obj object ref
    reference rref regexpref sref scalarref str string nil null undef undefined
    val value
);
{
    package isas;
    use Bubblegum::Syntax -isas;
    use Test::More;
    my @exports = map "isa_$_", @typelib;
    can_ok 'isas', $_ for @exports;
    ok isa_aref [];
    ok !isa_aref '';
    ok isa_arrayref [];
    ok !isa_arrayref '';
    ok isa_bool 1;
    ok isa_bool 0;
    ok isa_bool '';
    ok isa_bool undef;
    ok !isa_bool 100;
    ok isa_boolean 1;
    ok isa_boolean 0;
    ok isa_boolean '';
    ok isa_boolean undef;
    ok !isa_boolean 100;
    ok isa_class 'Test::More';
    ok !isa_class 'Acme::Widget';
    ok isa_classname 'Test::More';
    ok !isa_classname 'Acme::Widget';
    ok isa_cref sub {};
    ok !isa_cref undef;
    ok isa_coderef sub {};
    ok !isa_coderef undef;
    ok isa_def '';
    ok isa_def 0;
    ok !isa_def undef;
    ok isa_defined '';
    ok isa_defined 0;
    ok !isa_defined undef;
    ok isa_fh do { open my $fh, '<', \''; $fh };
    ok !isa_fh \'';
    ok isa_filehandle do { open my $fh, '<', \''; $fh };
    ok !isa_filehandle \'';
    ok isa_glob \*Test::More::EXPORT;
    ok !isa_glob \'';
    ok isa_globref \*Test::More::EXPORT;
    ok !isa_globref \'';
    ok isa_href {};
    ok !isa_href \'';
    ok isa_hashref {};
    ok !isa_hashref \'';
    ok isa_int 12345;
    ok !isa_int 123.45;
    ok isa_integer 12345;
    ok !isa_integer 123.45;
    ok isa_num 12345;
    ok isa_num 123.45;
    ok isa_num 0;
    ok !isa_num '';
    ok isa_number 12345;
    ok isa_number 123.45;
    ok isa_number 0;
    ok !isa_number '';
    ok isa_obj bless {}, main;
    ok !isa_obj {};
    ok isa_object bless {}, main;
    ok !isa_object {};
    ok isa_ref \'';
    ok isa_ref {};
    ok isa_ref [];
    ok !isa_ref '';
    ok isa_reference \'';
    ok isa_reference {};
    ok isa_reference [];
    ok !isa_reference '';
    ok isa_rref qr//;
    ok !isa_rref \'';
    ok isa_regexpref qr//;
    ok !isa_regexpref \'';
    ok isa_sref \'';
    ok !isa_sref {};
    ok !isa_sref '';
    ok isa_scalarref \'';
    ok !isa_scalarref {};
    ok !isa_scalarref '';
    ok isa_str '';
    ok isa_str 0;
    ok !isa_str undef;
    ok isa_string '';
    ok isa_string 0;
    ok !isa_string undef;
    ok isa_nil undef;
    ok !isa_nil '';
    ok !isa_nil 0;
    ok isa_null undef;
    ok !isa_null '';
    ok !isa_null 0;
    ok isa_undef undef;
    ok !isa_undef '';
    ok !isa_undef 0;
    ok isa_undefined undef;
    ok !isa_undefined '';
    ok !isa_undefined 0;
}
{
    package nots;
    use Bubblegum::Syntax -nots;
    use Test::More;
    my @exports = map "not_$_", @typelib;
    can_ok 'nots', $_ for @exports;
    ok !not_aref [];
    ok not_aref '';
    ok !not_arrayref [];
    ok not_arrayref '';
    ok !not_bool 1;
    ok !not_bool 0;
    ok !not_bool '';
    ok !not_bool undef;
    ok not_bool 100;
    ok !not_boolean 1;
    ok !not_boolean 0;
    ok !not_boolean '';
    ok !not_boolean undef;
    ok not_boolean 100;
    ok !not_class 'Test::More';
    ok not_class 'Acme::Widget';
    ok !not_classname 'Test::More';
    ok not_classname 'Acme::Widget';
    ok !not_cref sub {};
    ok not_cref undef;
    ok !not_coderef sub {};
    ok not_coderef undef;
    ok !not_def '';
    ok !not_def 0;
    ok not_def undef;
    ok !not_defined '';
    ok !not_defined 0;
    ok not_defined undef;
    ok !not_fh do { open my $fh, '<', \''; $fh };
    ok not_fh \'';
    ok !not_filehandle do { open my $fh, '<', \''; $fh };
    ok not_filehandle \'';
    ok !not_glob \*Test::More::EXPORT;
    ok not_glob \'';
    ok !not_globref \*Test::More::EXPORT;
    ok not_globref \'';
    ok !not_href {};
    ok not_href \'';
    ok !not_hashref {};
    ok not_hashref \'';
    ok !not_int 12345;
    ok not_int 123.45;
    ok !not_integer 12345;
    ok not_integer 123.45;
    ok !not_num 12345;
    ok !not_num 123.45;
    ok !not_num 0;
    ok not_num '';
    ok !not_number 12345;
    ok !not_number 123.45;
    ok !not_number 0;
    ok not_number '';
    ok !not_obj bless {}, main;
    ok not_obj {};
    ok !not_object bless {}, main;
    ok not_object {};
    ok !not_ref \'';
    ok !not_ref {};
    ok !not_ref [];
    ok not_ref '';
    ok !not_reference \'';
    ok !not_reference {};
    ok !not_reference [];
    ok not_reference '';
    ok !not_rref qr//;
    ok not_rref \'';
    ok !not_regexpref qr//;
    ok not_regexpref \'';
    ok !not_sref \'';
    ok not_sref {};
    ok not_sref '';
    ok !not_scalarref \'';
    ok not_scalarref {};
    ok not_scalarref '';
    ok !not_str '';
    ok !not_str 0;
    ok not_str undef;
    ok !not_string '';
    ok !not_string 0;
    ok not_string undef;
    ok !not_nil undef;
    ok not_nil '';
    ok not_nil 0;
    ok !not_null undef;
    ok not_null '';
    ok not_null 0;
    ok !not_undef undef;
    ok not_undef '';
    ok not_undef 0;
    ok !not_undefined undef;
    ok not_undefined '';
    ok not_undefined 0;
}
{
    package types;
    use Bubblegum::Syntax -types;
    use Test::More;
    my @exports = map "type_$_", @typelib;
    can_ok 'types', $_ for @exports;
    ok type_aref [];
    ok do { eval {type_aref ''}; $@ };
    ok type_arrayref [];
    ok do { eval {type_arrayref ''}; $@ };
    ok defined type_bool 1;
    ok defined type_bool 0;
    ok defined type_bool '';
    ok !type_bool undef;
    ok do { eval {type_bool 100}; $@ };
    ok defined type_boolean 1;
    ok defined type_boolean 0;
    ok defined type_boolean '';
    ok !type_boolean undef;
    ok do { eval {type_boolean 100}; $@ };
    ok type_class 'Test::More';
    ok do { eval {type_class 'Acme::Widget'}; $@ };
    ok type_classname 'Test::More';
    ok do { eval {type_classname 'Acme::Widget'}; $@ };
    ok type_cref sub {};
    ok do { eval {type_cref undef}; $@ };
    ok type_coderef sub {};
    ok do { eval {type_coderef undef}; $@ };
    ok defined type_def '';
    ok defined type_def 0;
    ok do { eval {type_def undef}; $@ };
    ok defined type_defined '';
    ok defined type_defined 0;
    ok do { eval {type_defined undef}; $@ };
    ok type_fh do { open my $fh, '<', \''; $fh };
    ok do { eval {type_fh \''}; $@ };
    ok type_filehandle do { open my $fh, '<', \''; $fh };
    ok do { eval {type_filehandle \''}; $@ };
    ok type_glob \*Test::More::EXPORT;
    ok do { eval {type_glob \''}; $@ };
    ok type_globref \*Test::More::EXPORT;
    ok do { eval {type_globref \''}; $@ };
    ok type_href {};
    ok do { eval {type_href \''}; $@ };
    ok type_hashref {};
    ok do { eval {type_hashref \''}; $@ };
    ok type_int 12345;
    ok do { eval {type_int 123.45}; $@ };
    ok type_integer 12345;
    ok do { eval {type_integer 123.45}; $@ };
    ok type_num 12345;
    ok type_num 123.45;
    ok defined type_num 0;
    ok do { eval {type_num ''}; $@ };
    ok type_number 12345;
    ok type_number 123.45;
    ok defined type_number 0;
    ok do { eval {type_number ''}; $@ };
    ok type_obj bless {}, main;
    ok do { eval {type_obj {}}; $@ };
    ok type_object bless {}, main;
    ok do { eval {type_object {}}; $@ };
    ok type_ref \'';
    ok type_ref {};
    ok type_ref [];
    ok do { eval {type_ref ''}; $@ };
    ok type_reference \'';
    ok type_reference {};
    ok type_reference [];
    ok do { eval {type_reference ''}; $@ };
    ok type_rref qr//;
    ok do { eval {type_rref \''}; $@ };
    ok type_regexpref qr//;
    ok do { eval {type_regexpref \''}; $@ };
    ok type_sref \'';
    ok do { eval {type_sref {}}; $@ };
    ok do { eval {type_sref ''}; $@ };
    ok type_scalarref \'';
    ok do { eval {type_scalarref {}}; $@ };
    ok do { eval {type_scalarref ''}; $@ };
    ok defined type_str '';
    ok defined type_str 0;
    ok do { eval {type_str undef}; $@ };
    ok defined type_string '';
    ok defined type_string 0;
    ok do { eval {type_string undef}; $@ };
    ok !type_nil undef;
    ok do { eval {type_nil ''}; $@ };
    ok do { eval {type_nil 0}; $@ };
    ok !type_null undef;
    ok do { eval {type_null ''}; $@ };
    ok do { eval {type_null 0}; $@ };
    ok !type_undef undef;
    ok do { eval {type_undef ''}; $@ };
    ok do { eval {type_undef 0}; $@ };
    ok !type_undefined undef;
    ok do { eval {type_undefined ''}; $@ };
    ok do { eval {type_undefined 0}; $@ };
}
{
    package typesof;
    use Bubblegum::Syntax -typesof;
    use Test::More;
    my @exports = map "typeof_$_", @typelib;
    can_ok 'typesof', $_ for @exports;
    ok 'CODE' eq ref typeof_aref;
    ok 'CODE' eq ref typeof_arrayref;
    ok 'CODE' eq ref typeof_bool;
    ok 'CODE' eq ref typeof_boolean;
    ok 'CODE' eq ref typeof_class;
    ok 'CODE' eq ref typeof_classname;
    ok 'CODE' eq ref typeof_cref;
    ok 'CODE' eq ref typeof_coderef;
    ok 'CODE' eq ref typeof_def;
    ok 'CODE' eq ref typeof_defined;
    ok 'CODE' eq ref typeof_fh;
    ok 'CODE' eq ref typeof_filehandle;
    ok 'CODE' eq ref typeof_glob;
    ok 'CODE' eq ref typeof_globref;
    ok 'CODE' eq ref typeof_href;
    ok 'CODE' eq ref typeof_hashref;
    ok 'CODE' eq ref typeof_int;
    ok 'CODE' eq ref typeof_integer;
    ok 'CODE' eq ref typeof_num;
    ok 'CODE' eq ref typeof_number;
    ok 'CODE' eq ref typeof_obj;
    ok 'CODE' eq ref typeof_object;
    ok 'CODE' eq ref typeof_ref;
    ok 'CODE' eq ref typeof_reference;
    ok 'CODE' eq ref typeof_rref;
    ok 'CODE' eq ref typeof_regexpref;
    ok 'CODE' eq ref typeof_sref;
    ok 'CODE' eq ref typeof_scalarref;
    ok 'CODE' eq ref typeof_str;
    ok 'CODE' eq ref typeof_string;
    ok 'CODE' eq ref typeof_nil;
    ok 'CODE' eq ref typeof_null;
    ok 'CODE' eq ref typeof_undef;
    ok 'CODE' eq ref typeof_undefined;
}
{
    package attrs;
    use Bubblegum::Class;
    use Bubblegum::Syntax -attr, -typesof;
    use Test::More;
    # has [name];
    has 'id';
    # has [name], default;
    has name => sub {'harry'};
    # has type, [name];
    has typeof_str, 'email';
    # has type, [name], default;
    has typeof_bool, employed => sub {1};
    # has (normal interface)
    has position => (
        is       => 'rw',
        required => 1
    );
    ok do { eval {attrs->new}; $@ };
    ok do { eval {attrs->new(email => 12345)}; $@ };
    ok do { eval {attrs->new(employed => 'yes')}; $@ };
    ok !do { eval {attrs->new(position => 'janitor')}; $@ };
    my $attrs = attrs->new(position => 'janitor');
    is $attrs->position, 'janitor';
    is $attrs->employed, 1;
    is $attrs->name, 'harry';
    ok !$attrs->email;
    ok !$attrs->id;
    ok do { eval {$attrs->email(undef)}; $@ };
    ok do { eval {$attrs->name('sally')}; $@ }; # read-only default
    ok do { eval {$attrs->email('root@local')}; $@ }; # read-only default
}
{
    package utils;
    use Bubblegum::Syntax -utils;
    use Test::More;
    can_ok 'utils', 'cwd';
    can_ok 'utils', 'date';
    can_ok 'utils', 'date_epoch';
    can_ok 'utils', 'date_format';
    can_ok 'utils', 'dump';
    can_ok 'utils', 'file';
    can_ok 'utils', 'find';
    can_ok 'utils', 'here';
    can_ok 'utils', 'home';
    can_ok 'utils', 'load';
    can_ok 'utils', 'merge';
    can_ok 'utils', 'path';
    can_ok 'utils', 'quote';
    can_ok 'utils', 'raise';
    can_ok 'utils', 'script';
    can_ok 'utils', 'unquote';
    can_ok 'utils', 'user';
    can_ok 'utils', 'user_info';
    can_ok 'utils', 'which';
    can_ok 'utils', 'will';
    is 'Bubblegum::Exception', ref do { eval {raise 'wtf'}; $@ };
}
{
    package misc::isas;
    use Bubblegum::Syntax qw(
        isa_aref isa_arrayref isa_bool isa_boolean isa_class isa_classname
        isa_cref isa_coderef isa_def isa_defined isa_fh isa_filehandle isa_glob
        isa_globref isa_href isa_hashref isa_int isa_integer isa_num isa_number
        isa_obj isa_object isa_ref isa_reference isa_rref isa_regexpref isa_sref
        isa_scalarref isa_str isa_string isa_nil isa_null isa_undef
        isa_undefined isa_val isa_value
    );
    use Test::More;
    can_ok 'misc::isas', 'isa_aref';
    can_ok 'misc::isas', 'isa_arrayref';
    can_ok 'misc::isas', 'isa_bool';
    can_ok 'misc::isas', 'isa_boolean';
    can_ok 'misc::isas', 'isa_class';
    can_ok 'misc::isas', 'isa_classname';
    can_ok 'misc::isas', 'isa_cref';
    can_ok 'misc::isas', 'isa_coderef';
    can_ok 'misc::isas', 'isa_def';
    can_ok 'misc::isas', 'isa_defined';
    can_ok 'misc::isas', 'isa_fh';
    can_ok 'misc::isas', 'isa_filehandle';
    can_ok 'misc::isas', 'isa_glob';
    can_ok 'misc::isas', 'isa_globref';
    can_ok 'misc::isas', 'isa_href';
    can_ok 'misc::isas', 'isa_hashref';
    can_ok 'misc::isas', 'isa_int';
    can_ok 'misc::isas', 'isa_integer';
    can_ok 'misc::isas', 'isa_num';
    can_ok 'misc::isas', 'isa_number';
    can_ok 'misc::isas', 'isa_obj';
    can_ok 'misc::isas', 'isa_object';
    can_ok 'misc::isas', 'isa_ref';
    can_ok 'misc::isas', 'isa_reference';
    can_ok 'misc::isas', 'isa_rref';
    can_ok 'misc::isas', 'isa_regexpref';
    can_ok 'misc::isas', 'isa_sref';
    can_ok 'misc::isas', 'isa_scalarref';
    can_ok 'misc::isas', 'isa_str';
    can_ok 'misc::isas', 'isa_string';
    can_ok 'misc::isas', 'isa_nil';
    can_ok 'misc::isas', 'isa_null';
    can_ok 'misc::isas', 'isa_undef';
    can_ok 'misc::isas', 'isa_undefined';
    can_ok 'misc::isas', 'isa_val';
    can_ok 'misc::isas', 'isa_value';
}
{
    package misc::nots;
    use Bubblegum::Syntax qw(
        not_aref not_arrayref not_bool not_boolean not_class not_classname
        not_cref not_coderef not_def not_defined not_fh not_filehandle not_glob
        not_globref not_href not_hashref not_int not_integer not_num not_number
        not_obj not_object not_ref not_reference not_rref not_regexpref not_sref
        not_scalarref not_str not_string not_nil not_null not_undef
        not_undefined not_val not_value
    );
    use Test::More;
    can_ok 'misc::nots', 'not_aref';
    can_ok 'misc::nots', 'not_arrayref';
    can_ok 'misc::nots', 'not_bool';
    can_ok 'misc::nots', 'not_boolean';
    can_ok 'misc::nots', 'not_class';
    can_ok 'misc::nots', 'not_classname';
    can_ok 'misc::nots', 'not_cref';
    can_ok 'misc::nots', 'not_coderef';
    can_ok 'misc::nots', 'not_def';
    can_ok 'misc::nots', 'not_defined';
    can_ok 'misc::nots', 'not_fh';
    can_ok 'misc::nots', 'not_filehandle';
    can_ok 'misc::nots', 'not_glob';
    can_ok 'misc::nots', 'not_globref';
    can_ok 'misc::nots', 'not_href';
    can_ok 'misc::nots', 'not_hashref';
    can_ok 'misc::nots', 'not_int';
    can_ok 'misc::nots', 'not_integer';
    can_ok 'misc::nots', 'not_num';
    can_ok 'misc::nots', 'not_number';
    can_ok 'misc::nots', 'not_obj';
    can_ok 'misc::nots', 'not_object';
    can_ok 'misc::nots', 'not_ref';
    can_ok 'misc::nots', 'not_reference';
    can_ok 'misc::nots', 'not_rref';
    can_ok 'misc::nots', 'not_regexpref';
    can_ok 'misc::nots', 'not_sref';
    can_ok 'misc::nots', 'not_scalarref';
    can_ok 'misc::nots', 'not_str';
    can_ok 'misc::nots', 'not_string';
    can_ok 'misc::nots', 'not_nil';
    can_ok 'misc::nots', 'not_null';
    can_ok 'misc::nots', 'not_undef';
    can_ok 'misc::nots', 'not_undefined';
    can_ok 'misc::nots', 'not_val';
    can_ok 'misc::nots', 'not_value';
}
{
    package misc::typesof;
    use Bubblegum::Syntax qw(
        typeof_aref typeof_arrayref typeof_bool typeof_boolean typeof_class
        typeof_classname typeof_cref typeof_coderef typeof_def typeof_defined
        typeof_fh typeof_filehandle typeof_glob typeof_globref typeof_href
        typeof_hashref typeof_int typeof_integer typeof_num typeof_number
        typeof_obj typeof_object typeof_ref typeof_reference typeof_rref
        typeof_regexpref typeof_sref typeof_scalarref typeof_str typeof_string
        typeof_nil typeof_null typeof_undef typeof_undefined typeof_val
        typeof_value
    );
    use Test::More;
    can_ok 'misc::typesof', 'typeof_aref';
    can_ok 'misc::typesof', 'typeof_arrayref';
    can_ok 'misc::typesof', 'typeof_bool';
    can_ok 'misc::typesof', 'typeof_boolean';
    can_ok 'misc::typesof', 'typeof_class';
    can_ok 'misc::typesof', 'typeof_classname';
    can_ok 'misc::typesof', 'typeof_cref';
    can_ok 'misc::typesof', 'typeof_coderef';
    can_ok 'misc::typesof', 'typeof_def';
    can_ok 'misc::typesof', 'typeof_defined';
    can_ok 'misc::typesof', 'typeof_fh';
    can_ok 'misc::typesof', 'typeof_filehandle';
    can_ok 'misc::typesof', 'typeof_glob';
    can_ok 'misc::typesof', 'typeof_globref';
    can_ok 'misc::typesof', 'typeof_href';
    can_ok 'misc::typesof', 'typeof_hashref';
    can_ok 'misc::typesof', 'typeof_int';
    can_ok 'misc::typesof', 'typeof_integer';
    can_ok 'misc::typesof', 'typeof_num';
    can_ok 'misc::typesof', 'typeof_number';
    can_ok 'misc::typesof', 'typeof_obj';
    can_ok 'misc::typesof', 'typeof_object';
    can_ok 'misc::typesof', 'typeof_ref';
    can_ok 'misc::typesof', 'typeof_reference';
    can_ok 'misc::typesof', 'typeof_rref';
    can_ok 'misc::typesof', 'typeof_regexpref';
    can_ok 'misc::typesof', 'typeof_sref';
    can_ok 'misc::typesof', 'typeof_scalarref';
    can_ok 'misc::typesof', 'typeof_str';
    can_ok 'misc::typesof', 'typeof_string';
    can_ok 'misc::typesof', 'typeof_nil';
    can_ok 'misc::typesof', 'typeof_null';
    can_ok 'misc::typesof', 'typeof_undef';
    can_ok 'misc::typesof', 'typeof_undefined';
    can_ok 'misc::typesof', 'typeof_val';
    can_ok 'misc::typesof', 'typeof_value';
}
{
    package misc::types;
    use Bubblegum::Syntax qw(
        type_aref type_arrayref type_bool type_boolean type_class type_classname
        type_cref type_coderef type_def type_defined type_fh type_filehandle
        type_glob type_globref type_href type_hashref type_int type_integer
        type_num type_number type_obj type_object type_ref type_reference
        type_rref type_regexpref type_sref type_scalarref type_str type_string
        type_nil type_null type_undef type_undefined type_val type_value
    );
    use Test::More;
    can_ok 'misc::types', 'type_aref';
    can_ok 'misc::types', 'type_arrayref';
    can_ok 'misc::types', 'type_bool';
    can_ok 'misc::types', 'type_boolean';
    can_ok 'misc::types', 'type_class';
    can_ok 'misc::types', 'type_classname';
    can_ok 'misc::types', 'type_cref';
    can_ok 'misc::types', 'type_coderef';
    can_ok 'misc::types', 'type_def';
    can_ok 'misc::types', 'type_defined';
    can_ok 'misc::types', 'type_fh';
    can_ok 'misc::types', 'type_filehandle';
    can_ok 'misc::types', 'type_glob';
    can_ok 'misc::types', 'type_globref';
    can_ok 'misc::types', 'type_href';
    can_ok 'misc::types', 'type_hashref';
    can_ok 'misc::types', 'type_int';
    can_ok 'misc::types', 'type_integer';
    can_ok 'misc::types', 'type_num';
    can_ok 'misc::types', 'type_number';
    can_ok 'misc::types', 'type_obj';
    can_ok 'misc::types', 'type_object';
    can_ok 'misc::types', 'type_ref';
    can_ok 'misc::types', 'type_reference';
    can_ok 'misc::types', 'type_rref';
    can_ok 'misc::types', 'type_regexpref';
    can_ok 'misc::types', 'type_sref';
    can_ok 'misc::types', 'type_scalarref';
    can_ok 'misc::types', 'type_str';
    can_ok 'misc::types', 'type_string';
    can_ok 'misc::types', 'type_nil';
    can_ok 'misc::types', 'type_null';
    can_ok 'misc::types', 'type_undef';
    can_ok 'misc::types', 'type_undefined';
    can_ok 'misc::types', 'type_val';
    can_ok 'misc::types', 'type_value';
}
{
    package misc::utils;
    use Bubblegum::Syntax qw(
        cwd date date_epoch date_format dump file find here home merge load
        path quote raise script unquote user user_info which will
    );
    use Test::More;
    can_ok 'misc::utils', 'cwd';
    can_ok 'misc::utils', 'date';
    can_ok 'misc::utils', 'date_epoch';
    can_ok 'misc::utils', 'date_format';
    can_ok 'misc::utils', 'dump';
    can_ok 'misc::utils', 'file';
    can_ok 'misc::utils', 'find';
    can_ok 'misc::utils', 'here';
    can_ok 'misc::utils', 'home';
    can_ok 'misc::utils', 'load';
    can_ok 'misc::utils', 'merge';
    can_ok 'misc::utils', 'path';
    can_ok 'misc::utils', 'quote';
    can_ok 'misc::utils', 'raise';
    can_ok 'misc::utils', 'script';
    can_ok 'misc::utils', 'unquote';
    can_ok 'misc::utils', 'user';
    can_ok 'misc::utils', 'user_info';
    can_ok 'misc::utils', 'which';
    can_ok 'misc::utils', 'will';
    is 'Bubblegum::Exception', ref do { eval {raise 'wtf'}; $@ };
}

done_testing;
