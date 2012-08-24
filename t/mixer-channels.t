#!/usr/local/bin/perl6

use lib 'lib';
use SDL;
use SDL::Mixer;
use SDL::Mixer::Channels;
use SDL::Mixer::Samples;
use Test;

plan 7;

is SDL::init( 255 ),             0, "SDL::init";

is( SDL::Mixer::open_audio( 44100, 36880, 2, 4096 ), 0, '[open_audio] ran');

is( SDL::Mixer::Channels::allocate_channels(4),      4, "[allocate_channels] 4 channels allocated"
);

is SDL::Mixer::Channels::volume( -1, 20 ),        128, 'SDL::Mixer::Channels::volume';
my $delay           = 5000;
my $audio_test_file = 'sample.wav';

my $sample_chunk = SDL::Mixer::Samples::load_WAV( $audio_test_file );
isa_ok( $sample_chunk, 'OpaquePointer', 'SDL::Mixer::Samples::load_WAV' );

# the following fucks up:
#my $playing_channel = SDL::Mixer::Channels::play_channel( -1, $sample_chunk, -1 );

# but this works:
my $playing_channel = SDL::Mixer::Channels::play_channel_timed( -1, $sample_chunk, -1, -1 );

ok $playing_channel >= 0, 'SDL::Mixer::Channels::play_channel';

sub callback( int $channel ) {
	say "hello $channel"
}

SDL::Mixer::Channels::channel_finished( &callback );

SDL::delay( $delay );
SDL::Mixer::close_audio();
pass '[close_audio] ran';
