use v6;
use NativeCall;
use SDL::PixelFormat;
use SDL::Rect;

class SDL::Surface is repr('CStruct') {
    has int32 $.flags;
    has SDL::PixelFormat $.format;
    has int32 $.w;
    has int32 $.h;
    has int16 $.pitch;
    has OpaquePointer $.pixels;
    has SDL::Rect $.clip_rect;
    has int32 $.refcount;
}

# vim: ft=perl6

