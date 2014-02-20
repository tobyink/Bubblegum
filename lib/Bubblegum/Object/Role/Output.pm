package Bubblegum::Object::Role::Output;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Defined';

# VERSION

requires 'print';
requires 'printf';
requires 'say';
requires 'sayf';

1;
