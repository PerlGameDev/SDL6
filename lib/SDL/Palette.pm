use v6;
use NativeCall;
use SDL::Color;

class SDL::Palette is repr('CStruct') {
    has int32 $.ncolors;
    has CArray[SDL::Color] $.colors;
}

# vim: ft=perl6

