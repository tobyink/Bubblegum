package Bubblegum::Object::Role::Indexed;

use 5.10.0;
use Bubblegum::Role 'requires', 'with';

with 'Bubblegum::Object::Role::Collection';

# VERSION

requires 'slice';

1;
