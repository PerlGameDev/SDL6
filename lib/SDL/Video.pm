use v6;
use NativeCall;
use SDL::Surface;

class SDL::Video {
    my sub SDL_SetVideoMode(int32 $width, int32 $height, int32 $bpp, int32 $flags)
        returns SDL::Surface
        is native('libSDL')
        { * }

    method set_video_mode(int32 $width, int32 $height, int32 $bpp, int32 $flags)
        returns SDL::Surface
        { SDL_SetVideoMode($width, $height, $bpp, $flags) }
}

# vim: ft=perl6

