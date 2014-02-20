package Bubblegum::Object::Role::Indexed;

use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Collection';

# VERSION

requires 'slice';

1;
