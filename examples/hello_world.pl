use v6;
use SDL;
use SDL::Video;

my $foo = SDL::Video.set_video_mode(640, 480, 32, 0);

sleep(2);

SDL.quit();

# vim: ft=perl

