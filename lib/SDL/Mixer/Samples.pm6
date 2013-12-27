
module SDL::Mixer::Samples;

use NativeCall;

our sub load_WAV( Str $file )	returns OpaquePointer {
	my $rw = rw_from_file( $file, 'rb' );
	return load_WAV_RW( $rw, 1 );
}
our sub load_WAV_RW( OpaquePointer, int )	returns OpaquePointer	is native('libSDL_mixer')	is symbol('Mix_LoadWAV_RW')	{ * }
our sub rw_from_file( Str, Str )			returns OpaquePointer	is native('libSDL')			is symbol('SDL_RWFromFile')	{ * }
