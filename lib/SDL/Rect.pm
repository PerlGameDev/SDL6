use v6;
use NativeCall;

class SDL::Rect is repr('CStruct') {
    has int16 $.x;
    has int16 $.y;
    has int16 $.w;
    has int16 $.h;

    method init($x, $y, $w, $h) {
        $!x = $x;
        $!y = $y;
        $!w = $w;
        $!h = $h;
    }
}

# vim: ft=perl6

