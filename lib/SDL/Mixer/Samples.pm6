
unit module SDL::Mixer::Samples;

use NativeCall;

our sub load_WAV( Str $file )  returns Pointer {
    my $rw = rw_from_file( $file, 'rb' );
    return load_WAV_RW( $rw, 1 );
}
our sub load_WAV_RW( Pointer, int32 )  returns Pointer  is native('SDL_mixer')  is symbol('Mix_LoadWAV_RW')  { * }
our sub rw_from_file( Str, Str )       returns Pointer  is native('SDL')        is symbol('SDL_RWFromFile')  { * }
