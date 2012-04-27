use v6;
use SDL;
use SDL::Video;
use SDL::Rect;

my $width = 640;
my $height = 480;
my $depth = 32;
my $flags = 0;

my $screen = SDL::Video.set_video_mode($width, $height, $depth, $flags);
say $screen.perl;

#my $rect = SDL::Rect.new(104, 101, 102, 103);
#my $rect = SDL::Rect.new(x => 104, y => 101, w => 102, h => 103);
my $rect = SDL::Rect.new();
#x => 104, y => 101, w => 102, h => 103);
$rect.init(100, 101, 102, 103);
#say $rect.perl;
#exit;

#my $color = SDL::Video.map_RGB($screen.format, 200, 100, 64);
my int32 $color = SDL::Video.map_RGB($screen.format, 0, 0, 255);
say $color;

SDL::Video.fill_rect($screen, SDL::Rect, $color);
#SDL::Video.fill_rect($screen, $rect, $color);

SDL::Video.flip($screen);
#SDL::Video.update_rect($screen, 0, 0, $width, $height);

sleep(2);

SDL.quit();

# vim: ft=perl6

