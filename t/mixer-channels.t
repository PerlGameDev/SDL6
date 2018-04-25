use SDL;
use NativeCall;
use Test;

plan 39;

Mix_Linked_Version() andthen diag sprintf 'Mix_Linked_Version v%d.%d.%d', .major, .minor, .patch;

# Setting up audio. You will hear nothing unless SDL_RELEASE_TESTING is set.
my $delay           = 50;
my $audio_test_file = 'share/silence.wav';
my $volume          = 1;

if %*ENV<SDL_RELEASE_TESTING> {
    $delay           = 300;
    $audio_test_file = 'share/sample.wav';
    $volume          = 20;
}

# Try to init audio. If it fails its not our fault, maybe the machine has no sound card.
if 0 != SDL_Init(16) {
    skip-rest( 'Failed to initialize audio with reason: "' ~ SDL_GetError() ~ '"' );
    exit;
}

# Basically the same
if 0 != Mix_OpenAudio(44100, 36880, 2, 4096) {
    skip-rest( 'Failed to open audio: "' ~ SDL_GetError() ~ '"' );
    exit;
}

# Hooray! So far...
pass 'Mix_OpenAudio ran';

# We request 4 channels, but we will actually just need one.
is Mix_AllocateChannels(4), 4, 'Mix_AllocateChannels allocated 4 channels';

# Changing the volume.
is Mix_Volume(-1, 10),     128, 'Mix_Volume set to 10, previously was 128';
is Mix_Volume(-1, $volume), 10, "Mix_Volume set to $volume, previously was 10";

# Loading audio file.
my $sample_chunk = Mix_LoadWAV($audio_test_file);
ok $sample_chunk ~~ Mix_Chunk, "Mix_LoadWAV loaded audio sample $audio_test_file";

# Play that audio file.
my $playing_channel = Mix_PlayChannelTimed(-1, $sample_chunk, -1, -1);
ok $playing_channel >= 0, 'Mix_PlayChannelTimed plays audio sample';
SDL_Delay($delay);

# Request the current states.
is Mix_Playing($playing_channel),       1, "Mix_Playing channel $playing_channel is playing";
is Mix_Paused($playing_channel),        0, "Mix_Paused channel $playing_channel is not paused";
is Mix_FadingChannel($playing_channel), 0, "Mix_FadingChannel channel $playing_channel is not fading";

# Preparing first callback test. NativeCall++, it's pretty easy to do.
my $callback_finished = 0;
sub callback_finished(int32 $channel) {
    pass "Mix_ChannelFinished called callback type: &callback for channel $channel";
    $callback_finished++;
}
Mix_ChannelFinished(&callback_finished);
pass 'Mix_ChannelFinished registered callback type: &callback';

# Stopping the music, the callback should be called then.
is Mix_HaltChannel($playing_channel), 0, "Mix_HaltChannel stopped channel $playing_channel";
is $callback_finished,                1, "Mix_ChannelFinished callback was called once";

# Checking states again.
is Mix_Playing($playing_channel),       0, "Mix_Playing channel $playing_channel is not playing";
is Mix_Paused($playing_channel),        0, "Mix_Paused channel $playing_channel is not paused";
is Mix_FadingChannel($playing_channel), 0, "Mix_FadingChannel channel $playing_channel is not fading";

# Playing and stopping again, the callback should get called again.
$playing_channel = Mix_PlayChannelTimed(-1, $sample_chunk, -1, -1);
SDL_Delay($delay);
is Mix_HaltChannel( $playing_channel ), 0, "Mix_HaltChannel stopped channel $playing_channel";
is $callback_finished,                  2, "Mix_ChannelFinished callback was called twice";

# Unregistering callback and checking that it doesn't get called.
Mix_ChannelFinished(Code);
pass 'Mix_ChannelFinished unregistered callback type: &callback';
$playing_channel = Mix_PlayChannelTimed(-1, $sample_chunk, -1, -1);
SDL_Delay($delay);
is Mix_HaltChannel($playing_channel), 0, "Mix_HaltChannel stopped channel $playing_channel";
is $callback_finished,                2, "Mix_ChannelFinished callback still was called twice";

$playing_channel = Mix_PlayChannelTimed(-1, $sample_chunk, -1, -1);
SDL_Delay($delay);

is MixerFading(Mix_FadingChannel($playing_channel)), MIX_NO_FADING, "Mix_FadingChannel channel $playing_channel is not fading";
is Mix_Playing($playing_channel), 1, "Mix_Playing channel $playing_channel is playing";
is Mix_Paused($playing_channel),  0, "Mix_Paused channel $playing_channel is not paused";

my $fading_channels = Mix_FadeOutChannel($playing_channel, $delay);
ok $fading_channels > 0, "Mix_FadeOutChannel $delay ms for $fading_channels channel(s)";
is MixerFading(Mix_FadingChannel($playing_channel)), MIX_FADING_OUT, "Mix_FadingChannel channel $playing_channel is fading out";

SDL_Delay($delay);

$playing_channel = Mix_FadeInChannel(-1, $sample_chunk, 0, $delay);

isnt $playing_channel, -1,"Mix_FadeInChannel $delay ms for channel $playing_channel";
is MixerFading(Mix_FadingChannel($playing_channel)), MIX_FADING_IN, "Mix_FadingChannel channel $playing_channel is fading in";
SDL_Delay($delay);

Mix_Pause(-1);
pass 'Mix_Pause ran';
is Mix_Paused($playing_channel),	1, "Mix_Paused channel $playing_channel is paused";
SDL_Delay(($delay / 4).Int);

Mix_Resume(-1);
pass 'Mix_Resume ran';

SDL_Delay($delay);

is Mix_HaltChannel($playing_channel), 0, "Mix_HaltChannel stop channel $playing_channel";
is Mix_Playing($playing_channel),	0, "Mix_Playing channel $playing_channel is not playing";

SDL_Delay($delay);

$playing_channel = Mix_PlayChannelTimed(-1, $sample_chunk, 0, $delay);

isnt $playing_channel, -1, "Mix_PlayChannelTimed play $delay ms for channel $playing_channel";
SDL_Delay(($delay / 4).Int);

my $expire_channel = Mix_ExpireChannel($playing_channel, $delay);
ok $expire_channel > 0, "Mix_ExpireChannel stops after $delay ms for $expire_channel channel(s)";

SDL_Delay($delay);

$playing_channel = Mix_FadeInChannelTimed(-1, $sample_chunk, 0, $delay, $delay * 2);

isnt $playing_channel, -1, "Mix_FadeInChannelTimed play {$delay * 2} ms after $delay ms fade in for channel $playing_channel";

isa-ok Mix_GetChunk($playing_channel), Mix_Chunk, 'Mix_GetChunk';

sleep(1);

SDL_Delay($delay);
Mix_CloseAudio();
pass 'Mix_CloseAudio ran';
