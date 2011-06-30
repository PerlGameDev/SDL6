#!perl6
# Install NativeCall.pm from http://github.com/jnthn/zavolaj.git
# Copy libSDL-1.2.so or dll into local directory and 
# perl6 SDL.pl :D

use v6;

use NativeCall;

class SDL_Surface is OpaquePointer;

sub SDL_SetVideoMode( Int $width, Int $height, Int $bpp, Int $flags )
	
	returns SDL_Surface 

	is native('libSDL') { }

sub SDL_Quit()
	is native('libSDL') { }

my $foo = SDL_SetVideoMode( 200, 200, 32, 0);

sleep(2);

SDL_Quit();
