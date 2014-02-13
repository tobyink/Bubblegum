package Bubblegum::Constraint;

use 5.10.0;
use utf8::all;
use strict;
use warnings;

use Scalar::Util 'blessed';
use base 'Exporter::Tiny';

# VERSION

use Types::Standard (
    assert_ArrayRef   => { -as => 'asa_arrayref' },
    assert_CodeRef    => { -as => 'asa_coderef' },
    assert_HashRef    => { -as => 'asa_hashref' },
    assert_Ref        => { -as => 'asa_ref' },
    assert_RegexpRef  => { -as => 'asa_regexp' },
    assert_Num        => { -as => 'asa_number' },
    assert_Str        => { -as => 'asa_string' },
    is_ArrayRef       => { -as => 'isa_arrayref' },
    is_Object         => { -as => 'isa_classref' },
    is_CodeRef        => { -as => 'isa_coderef' },
    is_HashRef        => { -as => 'isa_hashref' },
    is_RegexpRef      => { -as => 'isa_regexp' },
);

our @EXPORT_OK  = qw(
    asa_arrayref
    asa_coderef
    asa_hashref
    asa_number
    asa_ref
    asa_regexp
    asa_string
    isa_arrayref
    isa_classref
    isa_coderef
    isa_evenlist
    isa_hashref
    isa_regexp
);

sub isa_evenlist {
    @_ % 2 ? 0 : 1
}

1;
