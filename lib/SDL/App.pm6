
unit module SDL::App;

use NativeCall;
use SDL::Controller;
use SDL::Surface;

class SDL::App is SDL::Surface {
	also is SDL::Controller;
	method new( $w, $h, $bpp, $flags ) {
		self.bless( file => Str, rw => Pointer, pointer => _set_video_mode( $w, $h, $bpp, $flags ) );
	}
}

our sub _set_video_mode( int32 $w, int32 $h, int32 $bpp, int32 $flags )  returns SDL::Surface  is native('libSDL')  is symbol('SDL_SetVideoMode')  { * }
