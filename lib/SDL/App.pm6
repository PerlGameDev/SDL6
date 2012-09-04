
module SDL::App;

use NativeCall;
use SDL::Controller;
use SDL::Surface;

class SDL::App is SDL::Surface {
	also is SDL::Controller;
	method new( $w, $h, $bpp, $flags ) {
		self.bless( *, file => Str, rw => OpaquePointer, pointer => _set_video_mode( $w, $h, $bpp, $flags ) );
	}
}

our sub _set_video_mode( Int, Int, Int, Int )  returns OpaquePointer  is native('libSDL')  is symbol('SDL_SetVideoMode')  { * }

1;
