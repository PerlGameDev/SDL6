use v6;
use NativeCall;
use SDL::Surface;
use SDL::Rect;
use SDL::PixelFormat;

class SDL::Video {
    my sub SDL_SetVideoMode(int32 $width, int32 $height, int32 $bpp, int32 $flags)
        returns SDL::Surface
        is native('libSDL')
        { * }

    my sub SDL_UpdateRect(SDL::Surface $screen, int32 $x, int32 $y, int32 $w, int32 $h)
        is native('libSDL')
        { * }

    my sub SDL_FillRect(SDL::Surface $dest, SDL::Rect $dest_rect, int32 $color)
        returns int32
        is native('libSDL')
        { * }

    my sub SDL_MapRGB(SDL::PixelFormat $format, int8 $r, int8 $g, int8 $b)
        returns int32
        is native('libSDL')
        { * }

    my sub SDL_Flip(SDL::Surface $screen)
        returns int32
        is native('libSDL')
        { * }

    method set_video_mode(int32 $width, int32 $height, int32 $bpp, int32 $flags)
        returns SDL::Surface
        { SDL_SetVideoMode($width, $height, $bpp, $flags) }

    method update_rect($screen, $x, $y, $w, $h) {
        SDL_UpdateRect($screen, $x, $y, $w, $h);
    }

    method fill_rect($dest, $dest_rect, $color) {
        SDL_FillRect($dest, $dest_rect, $color)
    }

    method map_RGB($format, $r, $g, $b) { SDL_MapRGB($format, $r, $g, $b) }

    method flip($screen) { SDL_Flip($screen) }
}

# vim: ft=perl6

