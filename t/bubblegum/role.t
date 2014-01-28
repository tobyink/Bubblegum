use Bubblegum::Role;
use Test::More;

can_ok 'main', 'has';
can_ok 'main', 'gum';
can_ok 'main', 'with';
can_ok 'main', 'requires';

ok defined(gum), 'gum  accessor is defined';
isa_ok ref(gum), 'Bubblegum::Environment', 'gum accessor isa is correct';

done_testing;
