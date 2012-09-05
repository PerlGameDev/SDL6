
module SDL::Surface;

use NativeCall;
use SDL::Rect;

class SDL::Surface {
	has OpaquePointer $.pointer;
	has OpaquePointer $.rw;
	has Str           $.file;
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
	}

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

	method draw_line ( Int $x0 is copy = 0, Int $y0 is copy = 0, Int $x1 is copy = 0, Int $y1 is copy = 0, Int $color = 0xFFFFFFFF ) {
		my Int $dx  = ($x1 - $x0).abs;
		my Int $dy  = ($y1 - $y0).abs;
		my Int $sx  = $x0 < $x1 ?? 1 !! -1;
		my Int $sy  = $y0 < $y1 ?? 1 !! -1;
		my Int $err = $dx - $dy;

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


1;
