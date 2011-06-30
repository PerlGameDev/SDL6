use v6;
use Test;
use Test::Mock;
use SDL;

plan 2;

class Foo{
	method video( Int $width, Int $height, Int $bpp, Int $flags ) { return SDL_SetVideoMode(200,200,32,0); }
	method quit() { SDL_Quit(); }
}

my $x = mocked(Foo);

my $video = $x.video(200,200,32,0);

sleep(2);

$x.quit(); 

check-mock($x,
		*.called('video', times => 1),
		*.called('quit', times => 1),
		);

