unit module SDL::SFont;

use NativeCall;
use SDL::Rect;
use SDL::Surface;

class SDL::SFont is SDL::Surface {
	has $.char_pos = Array.new;
	method init {
		my $x       = 0;
		my $i       = 0;
		my $pointer = SDL::Surface::_get_pointer(self.struct[1]);
		my $color   = SDL::Surface::_map_rgb( $pointer, 255, 0, 255 );

		#if (SDL_MUSTLOCK(Font->Surface)) SDL_LockSurface(Font->Surface);
		while ( $x < self.width ) {
			if self.get_pixel( $x ) == $color {
				$!char_pos[$i++] = $x;
				while ($x < self.width - 1) && (self.get_pixel( $x ) == $color) {
					$x++
				}
				$!char_pos[$i++] = $x;
			}
			$x++;
		}

		#if (SDL_MUSTLOCK(Font->Surface)) SDL_UnlockSurface(Font->Surface);

		#Font->h=Font->Surface->h;
		#SDL_SetColorKey(Font->Surface, SDL_SRCCOLORKEY, SFont_GetPixel(Font->Surface, 0, Font->Surface->h-1));
	}

	multi method text_width ( Int $text ) {
		self.text_width( $text.Str )
	}

	multi method text_width ( Str $text ) {
		my Int $o;
		my Int $i = 0;
		my Int $x = 0;

		while $i < $text.chars {
			if $text.substr( $i, 1 ) ~~ ' ' {
				$x += $!char_pos[2] - $!char_pos[1];
			}
			else {
				$o  = ($text.substr( $i, 1 ).ord - 33) * 2 + 1;
				$x += $!char_pos[$o + 1] - $!char_pos[$o];
			}
			$i++;
		}

		return $x
	}

	multi method blit_text ( SDL::Surface $target, Int $x is copy, Int $y, Int $text ) {
		self.blit_text( $target, $x, $y, $text.Str );
	}

	multi method blit_text ( SDL::Surface $target, Int $x is copy, Int $y, Str $text ) {
		my Int $o;
		my Int $i = 0;

		while $i < $text.chars {
			if $text.substr( $i, 1 ) ~~ ' ' {
				$x += $!char_pos[2] - $!char_pos[1];
			}
			else {
				$o          = ($text.substr( $i, 1 ).ord - 33) * 2 + 1;
				my $srcrect = SDL::Rect.new( (($!char_pos[$o] + $!char_pos[$o - 1]) / 2).Int, 1,
				                             (($!char_pos[$o + 2] + $!char_pos[$o + 1]) / 2 - ($!char_pos[$o] + $!char_pos[$o - 1]) / 2).Int, self.height - 1 );
				my $dstrect = SDL::Rect.new( ($x - ($!char_pos[$o] - $!char_pos[$o - 1]) / 2).Int, $y, 0, 0 );

				SDL::Surface::_blit( self.pointer, $srcrect.CArray, $target.pointer, $dstrect.CArray ); 

				$x += $!char_pos[$o + 1] - $!char_pos[$o];
			}
			$i++;
		}
	}
}
