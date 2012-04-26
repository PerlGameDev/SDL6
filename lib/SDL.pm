use v6;
use NativeCall;

class SDL {

    my sub SDL_Init(int32 $flags)
        returns int32
        is native('libSDL')
        { * }

    my sub SDL_Quit()
	is native('libSDL')
        { * }

    method init(int32 $flags) returns int32 { SDL_Init($flags) }
    method quit() { SDL_Quit() }
}

# vim: ft=perl6

