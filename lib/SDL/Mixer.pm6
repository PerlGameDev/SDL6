
module SDL::Mixer;

use NativeCall;

our sub open_audio( int32, int32, int32, int32 )	returns Int	is native('libSDL_mixer')	is symbol('Mix_OpenAudio')			{ * }
our sub close_audio( )								returns Int	is native('libSDL_mixer')	is symbol('Mix_CloseAudio')			{ * }

1;
