
module SDL::Mixer::Channels;

use NativeCall;

our sub volume( int, int )									returns Int	is native('libSDL_mixer')	is symbol('Mix_Volume')				{ * }
our sub allocate_channels( int )							returns Int	is native('libSDL_mixer')	is symbol('Mix_AllocateChannels')	{ * }
our sub channel_finished( &callback(int) )					returns Int	is native('libSDL_mixer')	is symbol('Mix_ChannelFinished')	{ * }
our sub play_channel_timed( int, OpaquePointer, int, int )	returns Int	is native('libSDL_mixer')	is symbol('Mix_PlayChannelTimed')	{ * }
our sub play_channel( int $channel, OpaquePointer $sample, int $loops )	returns Int {
	return play_channel_timed( $channel, $sample, $loops, -1 );
}

1;
