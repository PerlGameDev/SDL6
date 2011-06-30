use v6;
use NativeCall;

class SDL_Surface is OpaquePointer;


sub SDL_SetVideoMode( Int $width, Int $height, Int $bpp, Int $flags )
	
	returns SDL_Surface 

	is native('libSDL') { }

sub SDL_Quit()
	is native('libSDL') { }


