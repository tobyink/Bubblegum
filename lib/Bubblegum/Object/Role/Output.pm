package Bubblegum::Object::Role::Output;

use 5.10.0;
use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Defined';

# VERSION

requires 'print';
requires 'printf';
requires 'say';
requires 'sayf';

1;
