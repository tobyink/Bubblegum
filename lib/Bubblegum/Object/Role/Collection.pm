package Bubblegum::Object::Role::Collection;

use 5.10.0;
use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Item';

# VERSION

requires 'defined';
requires 'each';
requires 'each_key';
requires 'each_n_values';
requires 'each_value';
requires 'exists';
requires 'iterator';
requires 'list';
requires 'keys';
requires 'get';
requires 'set';
requires 'values';

1;
