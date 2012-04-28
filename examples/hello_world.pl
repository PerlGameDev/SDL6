use v6;
use SDL;
use SDL::Video;
use SDL::Rect;

my $width = 640;
my $height = 480;
my $depth = 32;
my $flags = 0;

my $screen = SDL::Video.set_video_mode($width, $height, $depth, $flags);

my $rect = SDL::Rect.new();
$rect.init(100, 101, 102, 103);

my int32 $color = SDL::Video.map_RGB($screen.format, 0, 0, 255);

SDL::Video.fill_rect($screen, SDL::Rect, $color);

SDL::Video.flip($screen);

sleep(2);

SDL.quit();

# vim: ft=perl6

