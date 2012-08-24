
module SDL::Mixer::Effects;

use NativeCall;

our sub init( int32 )			returns Int				is native('libSDL')	is symbol('SDL_Init')			{ * }
our sub init_subsystem( int32 )	returns Int				is native('libSDL')	is symbol('SDL_InitSubSystem')	{ * }
our sub quit_subsystem( int32 )							is native('libSDL')	is symbol('SDL_QuitSubSystem')	{ * }
our sub was_init( int32 )		returns Int				is native('libSDL')	is symbol('SDL_WasInit')		{ * }
our sub get_ticks( )			returns Int				is native('libSDL')	is symbol('SDL_GetTicks')		{ * }
our sub delay( int32 )									is native('libSDL')	is symbol('SDL_Delay')			{ * }
our sub linked_version( )		returns SDL::Version	is native('libSDL')	is symbol('SDL_Linked_Version')	{ * }

1;
