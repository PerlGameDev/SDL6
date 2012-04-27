use v6;
use NativeCall;

class SDL::Rect is repr('CStruct') {
    has int16 $.x;
    has int16 $.y;
    has int16 $.w;
    has int16 $.h;

    #method new(int16 $x, int16 $y, int16 $w, int16 $h) {
        #self.bless(*, :$x, :$y, :$w, :$h);
        #self.bless(*, $x, $y, $w, $h);
        #my $rect = self.bless(*);
        #$rect.x($x);
        #, $x, $y, $w, $h);
        #return $rect;
    #}

    method init($x, $y, $w, $h) {
        $!x = $x;
        $!y = $y;
        $!w = $w;
        $!h = $h;
    }
}

# vim: ft=perl6

