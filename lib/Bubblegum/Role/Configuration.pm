package Bubblegum::Role::Configuration;

use 5.10.0;

use strict;
use utf8::all;
use warnings;

use Import::Into;
use Moo::Role;

use Bubblegum::Constraints ();
use Class::Forward ();
use feature ();
use mro ();

use Module::Find 'usesub';

use parent 'autobox';

# VERSION

requires 'import';

sub prerequisites {
    my ($class, $target) = @_;
    my $ignore = ($target =~ /^Bubblegum::Object/);

    # config
    mro::set_mro $target, 'c3';
    usesub Bubblegum::Object unless $ignore;

    # imports
    'strict'->import::into($target);
    'warnings'->import::into($target);
    'autodie'->import::into($target, ':all');
    'feature'->import::into($target, ':5.10');
    'utf8::all'->import::into($target);
    'English'->import::into($target, '-no_match_vars');

    # autobox
    $target->autobox::import(%{$Bubblegum::Constraints::EXTS});
}

1;
