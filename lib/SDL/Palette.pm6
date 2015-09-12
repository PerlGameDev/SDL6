
unit class SDL::Palette is repr('CStruct');

use NativeCall;
use SDL::Color;

has int32 $.ncolors;
has CArray[SDL::Color] $.colors;
