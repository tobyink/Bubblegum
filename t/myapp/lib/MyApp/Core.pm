package MyApp::Core;

use MyApp::Core::Object::Array;
use MyApp::Core::Object::Code;
use MyApp::Core::Object::Float;
use MyApp::Core::Object::Hash;
use MyApp::Core::Object::Integer;
use MyApp::Core::Object::Number;
use MyApp::Core::Object::Scalar;
use MyApp::Core::Object::String;
use MyApp::Core::Object::Undef;
use MyApp::Core::Object::Universal;

use parent 'Bubblegum';

my $USES = $Bubblegum::Constraints::USES;

$$USES{'ARRAY'}     = 'MyApp::Core::Object::Array';
$$USES{'CODE'}      = 'MyApp::Core::Object::Code';
$$USES{'FLOAT'}     = 'MyApp::Core::Object::Float';
$$USES{'HASH'}      = 'MyApp::Core::Object::Hash';
$$USES{'INTEGER'}   = 'MyApp::Core::Object::Integer';
$$USES{'NUMBER'}    = 'MyApp::Core::Object::Number';
$$USES{'SCALAR'}    = 'MyApp::Core::Object::Scalar';
$$USES{'STRING'}    = 'MyApp::Core::Object::String';
$$USES{'UNDEF'}     = 'MyApp::Core::Object::Undef';
$$USES{'UNIVERSAL'} = 'MyApp::Core::Object::Universal';

1;
