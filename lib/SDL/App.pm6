unit module SDL::App;

use NativeCall;
use SDL::Controller;
use SDL::Surface;
use SDL::Surfacish;

class SDL::App is SDL::Controller does SDL::Surfacish {
    method new( $w, $h, $bpp, $flags ) {
        self.bless: surface => SDL::Surface::_set_video_mode( $w, $h, $bpp, $flags )
    }

    method FALLBACK($name, |c) {
        $!surface."$name"(|c)
    }
}
