
unit class SDL::Rect is repr('CStruct');
has  int16 $.x;
has  int16 $.y;
has uint16 $.w;
has uint16 $.h;

multi method new( :$x!, :$y = 0, :$w = 0, :$h = 0 ) {
    self.bless( :$x, :$y, :$w, :$h );
}

multi method new( $x = 0, $y = 0, $w = 0, $h = 0 ) {
    self.bless( :$x, :$y, :$w, :$h );
}
