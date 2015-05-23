unit module SDL::Surface;

use NativeCall;
use SDL::Rect;

use soft;
use Inline;

class SDL::Surface {
	has OpaquePointer $.pointer;
	has OpaquePointer $.rw;
	has Str           $.file;
	has               $.struct;
	has               $.format;
	has               $.format_bpp;
	has               $.format_Bpp;
	has               $.format_rloss;
	has               $.format_gloss;
	has               $.format_bloss;
	has               $.format_aloss;
	has               $.format_rshift;
	has               $.format_gshift;
	has               $.format_bshift;
	has               $.format_ashift;
	has               $.format_rmask;
	has               $.format_gmask;
	has               $.format_bmask;
	has               $.format_amask;
	has               $.format_colorkey;
	has               $.format_alpha;
	has               $.palette;
	has               $.pixels;
	has Bool          $.is_bmp;
	has Bool          $.is_cur;
	has Bool          $.is_ico;
	has Bool          $.is_gif;
	has Bool          $.is_jpg;
	has Bool          $.is_lbm;
	has Bool          $.is_pcx;
	has Bool          $.is_png;
	has Bool          $.is_pnm;
	has Bool          $.is_tif;
	has Bool          $.is_xcf;
	has Bool          $.is_xpm;
	has Bool          $.is_xv;

	method new( Str $_file ) {
		self.bless( *, file => $_file, rw => OpaquePointer, pointer => OpaquePointer );
	}

	submethod BUILD( :$!file, :$!rw, :$!pointer ) {
		if $!file {
			$!rw = _rw_from_file( $!file, 'rb' );
		}
		elsif $!pointer {
			$!rw = _rw_from_const_mem( $!pointer, 42 ); # this rw doesn't get freed
		}

		$!is_bmp = _is_bmp( $!rw ).Bool;
		$!is_cur = _is_cur( $!rw ).Bool;
		$!is_ico = _is_ico( $!rw ).Bool;
		$!is_gif = _is_gif( $!rw ).Bool;
		$!is_jpg = _is_jpg( $!rw ).Bool;
		$!is_lbm = _is_lbm( $!rw ).Bool;
		$!is_pcx = _is_pcx( $!rw ).Bool;
		$!is_png = _is_png( $!rw ).Bool;
		$!is_pnm = _is_pnm( $!rw ).Bool;
		$!is_tif = _is_tif( $!rw ).Bool;
		$!is_xcf = _is_xcf( $!rw ).Bool;
		$!is_xpm = _is_xpm( $!rw ).Bool;
		$!is_xv  = _is_xv(  $!rw ).Bool;

		unless $!pointer {
			$!pointer = _load_rw( $!rw, 1 ); # $rw gets freed after that
		}

		$!struct  = get_buf( $!pointer, 42 );
		
		# typedef struct {
		#   SDL_Palette *palette;
		#   Uint8  BitsPerPixel;
		#   Uint8  BytesPerPixel;
		#   Uint8  Rloss, Gloss, Bloss, Aloss;
		#   Uint8  Rshift, Gshift, Bshift, Ashift;
		#   Uint32 Rmask, Gmask, Bmask, Amask;
		#   Uint32 colorkey;
		#   Uint8  alpha;
		# } SDL_PixelFormat;
		# 0: 0                        palette
		# 1: 08 00 00 00 00 00 04 20  Gshift Rshift Aloss Bloss Gloss Rloss BytesPerPixel BitsPerPixel
		# 2: ..000000FF. PP PP 18 10  Rmask Ashift Bshift
		# 3: ..00FF0000. ..0000FF00.  Bmask Gmask
		# 4: ..00000000. ..FF000000.  colorkey Amask
		# 5:                      00  alpha

		$!format          = get_buf( _get_pointer( $!struct[1] ), 41 );
		$!palette         = get_buf( _get_pointer( $!format[0] ), 35 ) if $!format[0];
		$!format_bpp      = $!format[1]       +& 0xFF;
		$!format_Bpp      = $!format[1] +>  8 +& 0xFF;
		$!format_rloss    = $!format[1] +> 16 +& 0xFF;
		$!format_gloss    = $!format[1] +> 24 +& 0xFF;
		$!format_bloss    = $!format[1] +> 32 +& 0xFF;
		$!format_aloss    = $!format[1] +> 40 +& 0xFF;
		$!format_rshift   = $!format[1] +> 48 +& 0xFF;
		$!format_gshift   = $!format[1] +> 56;
		$!format_bshift   = $!format[2]       +& 0xFF;
		$!format_ashift   = $!format[2] +>  8 +& 0xFF;
		$!format_rmask    = $!format[2] +> 32;
		$!format_gmask    = $!format[3]       +& 0xFFFFFFFF;
		$!format_bmask    = $!format[3] +> 32;
		$!format_amask    = $!format[4]       +& 0xFFFFFFFF;
		$!format_colorkey = $!format[4] +> 32;
		$!format_alpha    = $!format[5]       +& 0xFF;
#		printf( "typedef struct \{
#  SDL_Palette *palette;
#  Uint8  BitsPerPixel;
#  Uint8  BytesPerPixel;
#  Uint8  Rloss=%X, Gloss=%X, Bloss=%X, Aloss=%X;
#  Uint8  Rshift=%X, Gshift=%X, Bshift=%X, Ashift=%X;
#  Uint32 Rmask=%X, Gmask=%X, Bmask=%X, Amask=%X;
#  Uint32 colorkey;
#  Uint8  alpha;
#\} SDL_PixelFormat;\n",
#			$!format_rloss,  $!format_gloss,  $!format_bloss,  $!format_aloss,
#			$!format_rshift, $!format_gshift, $!format_bshift, $!format_ashift,
#			$!format_rmask,  $!format_gmask,  $!format_bmask,  $!format_amask,
#		);
		$!pixels = get_buf( _get_pointer( $!struct[4] ), self.pitch * self.height );
		self.init();
	}

	method init { }

	# accessors to the SDL_Surface structure
	method width  { $!struct[2]       +& 0xFFFFFFFF }
	method height { $!struct[2] +> 32 +& 0xFFFFFFFF }
	method pitch  { $!struct[3]       +& 0xFFFF     }

	method blit( SDL::Surface $target, SDL::Rect $clip = SDL::Rect, SDL::Rect $pos = SDL::Rect ) returns Int {
		_blit( $!pointer, $clip ?? $clip.CArray !! CArray[int], $target.pointer, $pos ?? $pos.CArray !! CArray[int] )
	}

	method update( $x = 0, $y = 0, $w = 0, $h = 0 ) {
		_update( $!pointer, $x, $y, $w, $h )
	}

	method get_clip_rect {
		my $clip = CArray[int].new();
		$clip[0] = 0;
		_get_clip_rect( $!pointer, $clip );
	}

	method flip {
		_flip( $!pointer )
	}

	method set_pixel ( Int $x = 0, Int $y = 0, Int $color = 0xFFFFFFFF ) {
		_fill_rect( $!pointer, SDL::Rect.new( $x, $y, 1, 1 ).CArray, $color )
	}

	method get_pixel ( Int $x = 0, Int $y = 0 ) returns Int {
		my $offset = ($x + $y * self.width) * $!format_Bpp;
		my $chunk  = ($offset / 8).Int; # amd64 only :/
		my $pos    = $offset % 8 * 8;
		return $pos ?? $!pixels[ $chunk ] +& 0xFFFFFFFF00000000 +> $pos !! $!pixels[ $chunk ] +& 0xFFFFFFFF; # 1 Bpp => 32bpp currently only
	}

	# http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
	method draw_line ( Int $x0 is copy = 0, Int $y0 is copy = 0, Int $x1 is copy = 0, Int $y1 is copy = 0, Int $color = 0xFFFFFFFF ) {
		my Int $dx  = ($x1 - $x0).abs;
		my Int $dy  = ($y1 - $y0).abs;
		my Int $sx  = $x0 < $x1 ?? 1 !! -1;
		my Int $sy  = $y0 < $y1 ?? 1 !! -1;
		my Int $err = $dx - $dy;
		
		if $dx == 0 {
			_fill_rect( $!pointer, SDL::Rect.new( $x0, $y0, 1, $dy ).CArray, $color );
		}
		elsif $dy == 0 {
			_fill_rect( $!pointer, SDL::Rect.new( $x0, $y0, $dx, 1 ).CArray, $color );
		}
		else {
			while 1 {
				_fill_rect( $!pointer, SDL::Rect.new( $x0, $y0, 1, 1 ).CArray, $color );
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

our sub _init( int )                                                     returns Int            is native('libSDL_image')  is symbol('IMG_Init')            { * }
our sub _load_rw( OpaquePointer, int )                                   returns OpaquePointer  is native('libSDL_image')  is symbol('IMG_Load_RW')         { * }
our sub _blit( OpaquePointer, CArray[int], OpaquePointer, CArray[int] )  returns Int            is native('libSDL')        is symbol('SDL_UpperBlit')       { * }
our sub _flip( OpaquePointer )                                           returns Int            is native('libSDL')        is symbol('SDL_Flip')            { * }
our sub _update( OpaquePointer, int, int, int, int )                                            is native('libSDL')        is symbol('SDL_UpdateRect')      { * }
our sub _is_bmp( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isBMP')           { * }
our sub _is_cur( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isCUR')           { * }
our sub _is_ico( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isICO')           { * }
our sub _is_gif( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isGIF')           { * }
our sub _is_jpg( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isJPG')           { * }
our sub _is_lbm( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isLBM')           { * }
our sub _is_pcx( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isPCX')           { * }
our sub _is_png( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isPNG')           { * }
our sub _is_pnm( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isPNM')           { * }
our sub _is_tif( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isTIF')           { * }
our sub _is_xcf( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isXCF')           { * }
our sub _is_xpm( OpaquePointer )                                         returns Int            is native('libSDL_image')  is symbol('IMG_isXPM')           { * }
our sub _is_xv( OpaquePointer )                                          returns Int            is native('libSDL_image')  is symbol('IMG_isXV')            { * }
our sub _rw_from_file( Str, Str )                                        returns OpaquePointer  is native('libSDL')        is symbol('SDL_RWFromFile')      { * }
our sub _rw_from_const_mem( OpaquePointer, int )                         returns OpaquePointer  is native('libSDL')        is symbol('SDL_RWFromConstMem')  { * }
our sub _fill_rect( OpaquePointer, CArray[int], int )                    returns Int            is native('libSDL')        is symbol('SDL_FillRect')        { * }
our sub _get_clip_rect( OpaquePointer, CArray[int] )                                            is native('libSDL')        is symbol('SDL_GetClipRect')     { * }
our sub _map_rgb( OpaquePointer, int, int, int )                         returns Int            is native('libSDL')        is symbol('SDL_MapRGB')          { * }


our sub _get_buf( OpaquePointer, CArray[int], int )  is inline('C')  {'
DLLEXPORT void *GetBuf( const void *from, void *to, size_t len )
{
	return memcpy( to, from, len );
}
'}

our sub _get_pointer( int )  is inline('C')  {'
DLLEXPORT void *GetPointer( size_t len )
{
	return (void *)len;
}
'}

our sub get_buf( $pointer, $size, $debug = False ) {
	my $struct  = CArray[int].new();
	my $bytes   = ($size / 8 + 0.5).Int;
	$struct[$_] = 0 for 0..$bytes;
	_get_buf( $pointer, $struct, $size );
	if $debug {
		printf( "%X\n", $struct[$_] ) for 0..$bytes;
		print "\n";
	}
	return $struct;
}
