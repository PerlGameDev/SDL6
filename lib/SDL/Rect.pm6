
module SDL::Rect;

use NativeCall; # for CArray type

class SDL::Rect {
	has Int $.x is rw;
	has Int $.y is rw;
	has Int $.w is rw;
	has Int $.h is rw;

	method new( $x = 0, $y = 0, $w = 0, $h = 0 ) {
		self.bless( *, x => $x, y => $y, w => $w, h => $h );
	}

	submethod BUILD( :$!x, :$!y, :$!w, :$!h ) { * }

	method CArray {
		my $carr = CArray[int].new();
		$carr[0] = ($!h +< 48) +| ($!w +< 32) +| ($!y +< 16) +| $!x;
		$carr
	}
}
