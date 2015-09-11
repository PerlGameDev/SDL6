
use NativeCall;

use SDL::Rect;
use SDL::PixelFormat;
#~ use soft;
#~ use Inline;

class SDL::Surface is repr('CStruct') {
    has uint32 $.flags;
    has SDL::PixelFormat $.format;
    has int32 $.w;
    has int32 $.h;
    has uint16 $.pitch;
    #~ has int16 $.pitch;
    has Pointer $.pixels;
    has int32 $.offset;
    has Pointer $.hwdata; # private_hwdata
    has SDL::Rect $.clip_rect;
    #~ has uint32 $.unused1;
    has int32 $.unused1;
    #~ has uint32 $.locked;
    has int32 $.locked;
    has Pointer $.map; # SDL::BlitMap
    #~ has uint32 $.format_version;
    has int32 $.format_version;
    has int32 $.refcount;

    #~ has Pointer       $.pointer;
    #~ has Pointer       $.rw;
    #~ has Str           $.file;
    #~ has SDL_Surface   $.surface;
    #~ has               $.struct;
    #~ has               $.format;
    #~ has               $.format_bpp;
    #~ has               $.format_Bpp;
    #~ has               $.format_rloss;
    #~ has               $.format_gloss;
    #~ has               $.format_bloss;
    #~ has               $.format_aloss;
    #~ has               $.format_rshift;
    #~ has               $.format_gshift;
    #~ has               $.format_bshift;
    #~ has               $.format_ashift;
    #~ has               $.format_rmask;
    #~ has               $.format_gmask;
    #~ has               $.format_bmask;
    #~ has               $.format_amask;
    #~ has               $.format_colorkey;
    #~ has               $.format_alpha;
    #~ has               $.palette;
    #~ has               $.pixels;
    #~ has Bool          $.is_bmp;
    #~ has Bool          $.is_cur;
    #~ has Bool          $.is_ico;
    #~ has Bool          $.is_gif;
    #~ has Bool          $.is_jpg;
    #~ has Bool          $.is_lbm;
    #~ has Bool          $.is_pcx;
    #~ has Bool          $.is_png;
    #~ has Bool          $.is_pnm;
    #~ has Bool          $.is_tif;
    #~ has Bool          $.is_xcf;
    #~ has Bool          $.is_xpm;
    #~ has Bool          $.is_xv;

    #~ method new( Str $file ) {
        #~ self.bless( :$file );
    #~ }

    #~ submethod BUILD( :$file, :$rw is copy = Pointer, :$pointer = Pointer ) {
        #~ if $file {
            #~ $rw = _rw_from_file( $file, 'rb' );
        #~ }
        #~ elsif $pointer {
            #~ $rw = _rw_from_const_mem( $pointer, 42 ); # this rw doesn't get freed
        #~ }

        #~ $!is_bmp = _is_bmp( $!rw ).Bool;
        #~ $!is_cur = _is_cur( $!rw ).Bool;
        #~ $!is_ico = _is_ico( $!rw ).Bool;
        #~ $!is_gif = _is_gif( $!rw ).Bool;
        #~ $!is_jpg = _is_jpg( $!rw ).Bool;
        #~ $!is_lbm = _is_lbm( $!rw ).Bool;
        #~ $!is_pcx = _is_pcx( $!rw ).Bool;
        #~ $!is_png = _is_png( $!rw ).Bool;
        #~ $!is_pnm = _is_pnm( $!rw ).Bool;
        #~ $!is_tif = _is_tif( $!rw ).Bool;
        #~ $!is_xcf = _is_xcf( $!rw ).Bool;
        #~ $!is_xpm = _is_xpm( $!rw ).Bool;
        #~ $!is_xv  = _is_xv(  $!rw ).Bool;

        #~ unless $!pointer {
            #~ $!pointer = _load_rw( $!rw, 1 ); # $rw gets freed after that
        #~ }


        #~ self.init();
    #~ }

    #~ method init { }

    #~ method blit( SDL::Surface $target, SDL::Rect $clip = SDL::Rect, SDL::Rect $pos = SDL::Rect ) returns Int {
        #~ _blit( $!pointer, $clip ?? $clip.CArray !! CArray[int], $target.pointer, $pos ?? $pos.CArray !! CArray[int] )
    #~ }

    #~ method update( $x = 0, $y = 0, $w = 0, $h = 0 ) {
        #~ _update( $!pointer, $x, $y, $w, $h )
    #~ }

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

    #~ method get_pixel ( Int $x = 0, Int $y = 0 ) returns Int {
        #~ my $offset = ($x + $y * self.width) * $!format_Bpp;
        #~ my $chunk  = ($offset / 8).Int; # amd64 only :/
        #~ my $pos    = $offset % 8 * 8;
        #~ return $pos ?? $!pixels[ $chunk ] +& 0xFFFFFFFF00000000 +> $pos !! $!pixels[ $chunk ] +& 0xFFFFFFFF; # 1 Bpp => 32bpp currently only
    #~ }

    #~ # http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
    #~ method draw_line ( Int $x0 is copy = 0, Int $y0 is copy = 0, Int $x1 is copy = 0, Int $y1 is copy = 0, Int $color = 0xFFFFFFFF ) {
        #~ my Int $dx  = ($x1 - $x0).abs;
        #~ my Int $dy  = ($y1 - $y0).abs;
        #~ my Int $sx  = $x0 < $x1 ?? 1 !! -1;
        #~ my Int $sy  = $y0 < $y1 ?? 1 !! -1;
        #~ my Int $err = $dx - $dy;
        
        #~ if $dx == 0 {
            #~ _fill_rect( $!pointer, SDL::Rect.new( $x0, $y0, 1, $dy ).CArray, $color );
        #~ }
        #~ elsif $dy == 0 {
            #~ _fill_rect( $!pointer, SDL::Rect.new( $x0, $y0, $dx, 1 ).CArray, $color );
        #~ }
        #~ else {
            #~ while 1 {
                #~ _fill_rect( $!pointer, SDL::Rect.new( $x0, $y0, 1, 1 ).CArray, $color );
                #~ last if $x0 == $x1 && $y0 == $y1;

                #~ my Int $e2 = 2 * $err;

                #~ if $e2 > -$dy {
                    #~ $err = $err - $dy;
                    #~ $x0  = $x0  + $sx;
                #~ }

                #~ if $e2 < $dx {
                    #~ $err = $err + $dx;
                    #~ $y0  = $y0  + $sy;
                #~ }
            #~ }
        #~ }
    #~ }
}

our sub _init( int32 )                                           returns Int           is native('libSDL_image')  is symbol('IMG_Init')            { * }
our sub _load_rw( Pointer, int32 )                               returns SDL::Surface  is native('libSDL_image')  is symbol('IMG_Load_RW')         { * }
our sub _blit( Pointer, CArray[int32], Pointer, CArray[int32] )  returns Int           is native('libSDL')        is symbol('SDL_UpperBlit')       { * }
our sub _flip( Pointer )                                         returns Int           is native('libSDL')        is symbol('SDL_Flip')            { * }
our sub _update( Pointer, int32, int32, int32, int32 )                                 is native('libSDL')        is symbol('SDL_UpdateRect')      { * }
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
our sub _fill_rect( Pointer, CArray[int32], int32 )              returns Int           is native('libSDL')        is symbol('SDL_FillRect')        { * }
our sub _get_clip_rect( Pointer, CArray[int32] )                                       is native('libSDL')        is symbol('SDL_GetClipRect')     { * }
our sub _map_rgb( Pointer, int32, int32, int32 )                 returns Int           is native('libSDL')        is symbol('SDL_MapRGB')          { * }
