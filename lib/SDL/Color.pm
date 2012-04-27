use v6;
use NativeCall;

class SDL::Color is repr('CStruct') {
    has int8 $.r;
    has int8 $.g;
    has int8 $.b;
    has int8 $.unused;
}

# vim: ft=perl6

