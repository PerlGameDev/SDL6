
module SDL::Mixer;

use NativeCall;

our constant $MIX_INIT_FLAC is export(:mix_init) = 0x00000001;
our constant $MIX_INIT_MOD  = 0x00000002;
our constant $MIX_INIT_MP3  = 0x00000004;
our constant $MIX_INIT_OGG  = 0x00000008;

our constant $MIX_CHANNELS          = 8;
our constant $MIX_DEFAULT_FORMAT    = 32784;
our constant $MIX_DEFAULT_FREQUENCY = 22050;
our constant $MIX_DEFAULT_CHANNELS  = 2;
our constant $MIX_MAX_VOLUME        = 128;
our constant $MIX_CHANNEL_POST      = -2;

our constant $MIX_NO_FADING  = 0;
our constant $MIX_FADING_OUT = 1;
our constant $MIX_FADING_IN  = 2;

our constant $MUS_NONE     = 0;
our constant $MUS_CMD      = 1;
our constant $MUS_WAV      = 2;
our constant $MUS_MOD      = 3;
our constant $MUS_MID      = 4;
our constant $MUS_OGG      = 5;
our constant $MUS_MP3      = 6;
our constant $MUS_MP3_MAD  = 7;
our constant $MUS_MP3_FLAC = 8;

our sub open_audio( int32, int32, int32, int32 )	returns Int	is native('libSDL_mixer')	is symbol('Mix_OpenAudio')	{ * }
our sub close_audio( )								returns Int	is native('libSDL_mixer')	is symbol('Mix_CloseAudio')	{ * }
