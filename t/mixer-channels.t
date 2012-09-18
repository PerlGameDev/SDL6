#!/usr/local/bin/perl6

use lib 'lib';
use SDL;
use SDL::Mixer;
use SDL::Mixer::Channels;
use SDL::Mixer::Samples;
use Test;

plan *;

# Setting up audio. You will hear nothing unless SDL_RELEASE_TESTING is set.
my $delay           = 50;
my $audio_test_file = 'share/silence.wav';
my $volume          = 1;

if %*ENV{'SDL_RELEASE_TESTING'} {
	$delay           = 300;
	$audio_test_file = 'share/sample.wav';
	$volume          = 20;
}

# Try to init audio. If it fails its not our fault, maybe the machine has no sound card.
if 0 != SDL::init( 16 ) {
	skip_rest( 'Failed to initialize audio with reason: "' ~ SDL::get_error() ~ '"' );
	exit;
}

# Basically the same
if 0 != SDL::Mixer::open_audio( 44100, 36880, 2, 4096 ) {
	skip_rest( 'Failed to open audio: "' ~ SDL::get_error() ~ '"' );
	exit;
}

# Hooray! So far...
pass '[open_audio] ran';

# We request 4 channels, but we will actually just need one.
is SDL::Mixer::Channels::allocate( 4 ), 4, '[allocate] allocated 4 channels';

# Changing the volume.
is SDL::Mixer::Channels::volume( -1, 10 ),     128, '[volume] set to 10, previously was 128';
is SDL::Mixer::Channels::volume( -1, $volume ), 10, "[volume] set to $volume, previously was 10";

# Loading audio file.
my $sample_chunk = SDL::Mixer::Samples::load_WAV( $audio_test_file );
isa_ok( $sample_chunk, 'OpaquePointer', "[load_WAV] loaded audio sample $audio_test_file" );

# Play that audio file.
my $playing_channel = SDL::Mixer::Channels::play( -1, $sample_chunk, -1, -1 );
ok $playing_channel >= 0,                                '[play] plays audio sample';
SDL::delay( $delay );

# Request the current states.
is SDL::Mixer::Channels::playing( $playing_channel ), 1, "[playing] channel $playing_channel is playing";
is SDL::Mixer::Channels::paused( $playing_channel ),  0, "[paused] channel $playing_channel is not paused";
is SDL::Mixer::Channels::fading( $playing_channel ),  0, "[fading] channel $playing_channel is not fading";

# Preparing first callback test. NativeCall++, its pretty easy to do.
my $callback_finished = 0;
sub callback_finished( int $channel ) {
	pass "[finished] called callback type: &callback for channel $channel";
	$callback_finished++;
}
SDL::Mixer::Channels::finished( &callback_finished );
pass '[finished] registered callback type: &callback';

# Stopping the music, the callback should be called then.
is SDL::Mixer::Channels::halt( $playing_channel ),    0, "[halt_channel] stopped channel $playing_channel";
is $callback_finished,                                1, "[finished] callback was called once";

# Checking states again.
is SDL::Mixer::Channels::playing( $playing_channel ), 0, "[playing] channel $playing_channel is not playing";
is SDL::Mixer::Channels::paused( $playing_channel ),  0, "[paused] channel $playing_channel is not paused";
is SDL::Mixer::Channels::fading( $playing_channel ),  0, "[fading] channel $playing_channel is not fading";

# Playing and stopping again, the callback should get called again.
$playing_channel = SDL::Mixer::Channels::play( -1, $sample_chunk, -1, -1 );
SDL::delay( $delay );
is SDL::Mixer::Channels::halt( $playing_channel ),    0, "[halt_channel] stopped channel $playing_channel";
is $callback_finished,                                2, "[finished] callback was called twice";

# Unregistering callback and checking that it doesn't get called.
SDL::Mixer::Channels::finished( Code );
pass '[finished] unregistered callback type: &callback';
$playing_channel = SDL::Mixer::Channels::play( -1, $sample_chunk, -1, -1 );
SDL::delay( $delay );
is SDL::Mixer::Channels::halt( $playing_channel ),    0, "[halt_channel] stopped channel $playing_channel";
is $callback_finished,                                2, "[finished] callback still was called twice";






#is( SDL::Mixer::Channels::fading_channel($playing_channel),	MIX_NO_FADING, "[fading_channel] channel $playing_channel is not fading");
#is( SDL::Mixer::Channels::playing($playing_channel),	1, "[playing] channel $playing_channel is playing");
#is( SDL::Mixer::Channels::paused($playing_channel),	0, "[paused] channel $playing_channel is not paused");

#my $fading_channels = SDL::Mixer::Channels::fade_out_channel( $playing_channel, $delay );
#is( $fading_channels > 0,	1, "[fade_out_channel] $delay ms for $fading_channels channel(s)");
#is( SDL::Mixer::Channels::fading_channel($playing_channel),	MIX_FADING_OUT, "[fading_channel] channel $playing_channel is fading out");

#SDL::delay($delay);

#$playing_channel = SDL::Mixer::Channels::fade_in_channel( -1, $sample_chunk, 0, $delay );

#isnt(	$playing_channel, -1,"[fade_in_channel] $delay ms for channel $playing_channel");
#is( SDL::Mixer::Channels::fading_channel($playing_channel),	MIX_FADING_IN, "[fading_channel] channel $playing_channel is fading in");
#SDL::delay($delay);

#SDL::Mixer::Channels::pause(-1);
#pass '[pause] ran';
#is( SDL::Mixer::Channels::paused($playing_channel),	1, "[paused] channel $playing_channel is paused");
#SDL::delay( $delay / 4 );

#SDL::Mixer::Channels::resume(-1);
#pass '[resume] ran';

#SDL::delay($delay);

#is( SDL::Mixer::Channels::halt_channel($playing_channel),	0, "[halt_channel] stop channel $playing_channel");
#is( SDL::Mixer::Channels::playing($playing_channel),	0, "[playing] channel $playing_channel is not playing");

#SDL::delay($delay);

#$playing_channel = SDL::Mixer::Channels::play_channel_timed( -1, $sample_chunk, 0, $delay );

#isnt(	$playing_channel, -1,	"[play_channel_timed] play $delay ms for channel $playing_channel");
#SDL::delay( $delay / 4 );

#my $expire_channel = SDL::Mixer::Channels::expire_channel( $playing_channel, $delay );

#is( $expire_channel > 0,	1,	"[expire_channel] stops after $delay ms for $expire_channel channel(s)");

#SDL::delay($delay);

#$playing_channel = SDL::Mixer::Channels::fade_in_channel_timed(	-1, $sample_chunk, 0, $delay,	$delay * 2);

#isnt(	$playing_channel, -1,	"[fade_in_channel_timed] play " . ( $delay * 2 ) . " ms after $delay ms fade in for channel $playing_channel");

#isa_ok(SDL::Mixer::Channels::get_chunk($playing_channel),'SDL::Mixer::MixChunk', '[get_chunk]');
#is( $finished > 0, 1, '[callback_finished] called the callback got ' . $finished);

#sleep(1);








SDL::delay( $delay );
SDL::Mixer::close_audio();
pass '[close_audio] ran';

done;
