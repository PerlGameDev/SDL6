unit module SDL::Surface;

use NativeCall;

use SDL::Rect;
use SDL::PixelFormat;
use SDL::CStructs;
use SDL::Surfacish;

class SDL::Surface is SDL_Surface is repr('CStruct') {

    multi method new(Str $file) {
        _load($file)
    }

    multi method blit( SDL::Surface $target, SDL::Rect $clip = SDL::Rect, SDL::Rect $pos = SDL::Rect ) returns int32 {
        _blit( self, $clip, $target,         $pos )
    }
    multi method blit( SDL::Surfacish $target, SDL::Rect $clip = SDL::Rect, SDL::Rect $pos = SDL::Rect ) returns int32 {
        _blit( self, $clip, $target.surface, $pos )
    }

    method update( $x = 0, $y = 0, $w = 0, $h = 0 ) {
        _update( self, $x, $y, $w, $h )
    }

    #~ method get_clip_rect {
        #~ my $clip = CArray[int].new();
        #~ $clip[0] = 0;
        #~ _get_clip_rect( $!pointer, $clip );
    #~ }

    #~ method flip {
        #~ _flip( $!pointer )
    #~ }

    #~ method set_pixel ( Int $x = 0, Int $y = 0, Int $color = 0xFFFFFFFF ) {
        #~ _fill_rect( $!pointer, SDL::Rect.new( $x, $y, 1, 1 ).CArray, $color )
    #~ }

    method get_pixel( Int $x = 0, Int $y = 0 ) {
        my $offset = ($x + $y * self.w) * $.format.BytesPerPixel;
        do given $.format.BitsPerPixel {
            when  8 { nativecast(uint8,  Pointer.new(+$.pixels + $offset)) }
            when 16 { nativecast(uint16, Pointer.new(+$.pixels + $offset)) }
            when 32 { nativecast(uint32, Pointer.new(+$.pixels + $offset)) }
        }
    }

    # http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
    method draw_line( Int $x0 is copy = 0, Int $y0 is copy = 0, Int $x1 is copy = 0, Int $y1 is copy = 0, Int $color = 0xFFFFFFFF ) {
        my Int $dx  = ($x1 - $x0).abs;
        my Int $dy  = ($y1 - $y0).abs;
        my Int $sx  = $x0 < $x1 ?? 1 !! -1;
        my Int $sy  = $y0 < $y1 ?? 1 !! -1;
        my Int $err = $dx - $dy;

        if $dx == 0 {
            _fill_rect( self, SDL::Rect.new( $x0, $y0, 1, $dy ), $color );
        }
        elsif $dy == 0 {
            _fill_rect( self, SDL::Rect.new( $x0, $y0, $dx, 1 ), $color );
        }
        else {
            while 1 {
                _fill_rect( self, SDL::Rect.new( $x0, $y0, 1, 1 ), $color );
                last if $x0 == $x1 && $y0 == $y1;

                my Int $e2 = 2 * $err;

                if $e2 > -$dy {
                    $err = $err - $dy;
                    $x0  = $x0  + $sx;
                }

                if $e2 < $dx {
                    $err = $err + $dx;
                    $y0  = $y0  + $sy;
                }
            }
        }
    }
}

our sub _set_video_mode( int32 $w, int32 $h, int32 $bpp, int32 $flags )  returns SDL::Surface  is native('libSDL')  is symbol('SDL_SetVideoMode')  { * }
our sub _init( int32 )                                           returns Int           is native('libSDL_image')  is symbol('IMG_Init')            { * }
our sub _load( Str )                                             returns SDL::Surface  is native('libSDL_image')  is symbol('IMG_Load')            { * }
our sub _load_rw( Pointer, int32 )                               returns SDL::Surface  is native('libSDL_image')  is symbol('IMG_Load_RW')         { * }
our sub _blit( SDL_Surface, SDL_Rect, SDL_Surface, SDL_Rect )    returns int32         is native('libSDL')        is symbol('SDL_UpperBlit')       { * }
our sub _flip( Pointer )                                         returns Int           is native('libSDL')        is symbol('SDL_Flip')            { * }
our sub _update( SDL_Surface, int32, int32, int32, int32 )                             is native('libSDL')        is symbol('SDL_UpdateRect')      { * }
our sub _is_bmp( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isBMP')           { * }
our sub _is_cur( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isCUR')           { * }
our sub _is_ico( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isICO')           { * }
our sub _is_gif( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isGIF')           { * }
our sub _is_jpg( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isJPG')           { * }
our sub _is_lbm( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isLBM')           { * }
our sub _is_pcx( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isPCX')           { * }
our sub _is_png( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isPNG')           { * }
our sub _is_pnm( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isPNM')           { * }
our sub _is_tif( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isTIF')           { * }
our sub _is_xcf( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isXCF')           { * }
our sub _is_xpm( Pointer )                                       returns Int           is native('libSDL_image')  is symbol('IMG_isXPM')           { * }
our sub _is_xv( Pointer )                                        returns Int           is native('libSDL_image')  is symbol('IMG_isXV')            { * }
our sub _rw_from_file( Str, Str )                                returns Pointer       is native('libSDL')        is symbol('SDL_RWFromFile')      { * }
our sub _rw_from_const_mem( Pointer, int32 )                     returns Pointer       is native('libSDL')        is symbol('SDL_RWFromConstMem')  { * }
our sub _fill_rect( SDL_Surface, SDL_Rect, int32 )               returns int32         is native('libSDL')        is symbol('SDL_FillRect')        { * }
our sub _get_clip_rect( Pointer, CArray[int32] )                                       is native('libSDL')        is symbol('SDL_GetClipRect')     { * }
our sub _map_rgb( SDL_PixelFormat, uint8, uint8, uint8 )         returns uint32        is native('libSDL')        is symbol('SDL_MapRGB')          { * }
