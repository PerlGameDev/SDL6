module SDL::Mixer::Channels;

use NativeCall;

# native calls to libSDL_mixer
# Note: 'is symbol' will be called 'is named' in future
our sub volume( int, int )                     returns Int  is native('libSDL_mixer')  is symbol('Mix_Volume')            { * }
our sub allocate( int )                        returns Int  is native('libSDL_mixer')  is symbol('Mix_AllocateChannels')  { * }
our sub finished( Code &callback(int) )        returns Int  is native('libSDL_mixer')  is symbol('Mix_ChannelFinished')   { * }
our sub _play( int, OpaquePointer, int, int )  returns Int  is native('libSDL_mixer')  is symbol('Mix_PlayChannelTimed')  { * }
our sub halt( int )                            returns Int  is native('libSDL_mixer')  is symbol('Mix_HaltChannel')       { * }
our sub playing( int )                         returns Int  is native('libSDL_mixer')  is symbol('Mix_Playing')           { * }
our sub paused( int)                           returns Int  is native('libSDL_mixer')  is symbol('Mix_Paused')            { * }
our sub fading( int )                          returns Int  is native('libSDL_mixer')  is symbol('Mix_FadingChannel')     { * }

# wrappers (for example to support optional parameters)
# Note: dont use typed parameters here
our sub play( $channel, $sample, $loops, $time = -1 )  returns Int  { _play( $channel, $sample, $loops, $time ) }
