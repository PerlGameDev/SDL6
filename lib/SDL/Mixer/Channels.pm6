unit module SDL::Mixer::Channels;

use NativeCall;

# native calls to libSDL_mixer
# Note: 'is symbol' will be called 'is named' in future
our sub volume( int32, int32 )                 returns int32  is native('libSDL_mixer')  is symbol('Mix_Volume')            { * }
our sub allocate( int32 )                      returns int32  is native('libSDL_mixer')  is symbol('Mix_AllocateChannels')  { * }
our sub finished( &callback (int32) )          returns int32  is native('libSDL_mixer')  is symbol('Mix_ChannelFinished')   { * }
our sub _play( int32, Pointer, int32, int32 )  returns int32  is native('libSDL_mixer')  is symbol('Mix_PlayChannelTimed')  { * }
our sub halt( int32 )                          returns int32  is native('libSDL_mixer')  is symbol('Mix_HaltChannel')       { * }
our sub playing( int32 )                       returns int32  is native('libSDL_mixer')  is symbol('Mix_Playing')           { * }
our sub paused( int32 )                        returns int32  is native('libSDL_mixer')  is symbol('Mix_Paused')            { * }
our sub fading( int32 )                        returns int32  is native('libSDL_mixer')  is symbol('Mix_FadingChannel')     { * }

# wrappers (for example to support optional parameters)
# Note: dont use typed parameters here
our sub play( $channel, $sample, $loops, $time = -1 )  returns int32  { _play( $channel, $sample, $loops, $time ) }
