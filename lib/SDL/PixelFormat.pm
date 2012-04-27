use v6;
use NativeCall;
use SDL::Palette;

class SDL::PixelFormat is repr('CStruct') {
    has SDL::Palette $.palette;
    has int8 $.BitsPerPixel;
    has int8 $.BytesPerPixel;
    has int8 $.Rloss;
    has int8 $.Gloss;
    has int8 $.Bloss;
    has int8 $.Aloss;
    has int8 $.Rshift;
    has int8 $.Gshift;
    has int8 $.Bshift;
    has int8 $.Ashift;
    has int32 $.Rmask;
    has int32 $.Gmask;
    has int32 $.Bmask;
    has int32 $.Amask;
    has int32 $.colorkey;
    has int8 $.alpha;
}

# vim: ft=perl6

