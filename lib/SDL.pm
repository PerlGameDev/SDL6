use v6;
use NativeCall;

class SDL {

    my sub SDL_Init(int32 $flags)
        returns int32
        is native('libSDL')
        { * }

    my sub SDL_InitSubSystem(int32 $flags)
        returns int32
        is native('libSDL')
        { * }

    my sub SDL_QuitSubSystem(int32 $flags)
	is native('libSDL')
        { * }

    my sub SDL_Quit()
	is native('libSDL')
        { * }

    my sub SDL_WasInit(int32 $flags)
        returns int32
        is native('libSDL')
        { * }

    my sub SDL_GetError()
        returns Str
        is native('libSDL')
        { * }

    method init(int32 $flags) returns int32 { SDL_Init($flags) }

    method init_sub_system(int32 $flags) returns int32 {
        SDL_InitSubSystem($flags)
    }

    method quit_sub_system(int32 $flags) { SDL_QuitSubSystem($flags) }

    method quit() { SDL_Quit() }

    method was_init(int32 $flags) returns int32 { SDL_WasInit($flags) }

    method get_error() returns Str { SDL_GetError() }
}

# vim: ft=perl6

