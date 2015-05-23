unit module SDL::SFont;

use NativeCall;
use SDL::Rect;
use SDL::Surface;
use SDL::Surfacish;

unit class SDL::SFont does SDL::Surfacish;
has $.char_pos = [];

method new($file) {
    my $self = self.bless: surface => SDL::Surface.new($file);
    $self.init;
    $self
}

method FALLBACK($name, |c) {
    $!surface."$name"(|c)
}

method init {
    my $x     = 0;
    my $i     = 0;
    my $color = SDL::Surface::_map_rgb(self.format, 255, 0, 255);

    #if (SDL_MUSTLOCK(Font->Surface)) SDL_LockSurface(Font->Surface);
    while ( $x < self.w ) {
        if self.get_pixel( $x ) == $color {
            $!char_pos[$i++] = $x;
            while ($x < self.surface.w - 1) && (self.surface.get_pixel( $x ) == $color) {
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

method text_width ( Str() $text ) {
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

method blit_text($target, Int $x is copy, Int $y, Str() $text ) {
    my Int $o;
    my Int $i = 0;

    while $i < $text.chars {
        if $text.substr( $i, 1 ) ~~ ' ' {
            $x += $!char_pos[2] - $!char_pos[1];
        }
        else {
            $o          = ($text.substr( $i, 1 ).ord - 33) * 2 + 1;
            my $srcrect = SDL::Rect.new( (($!char_pos[$o] + $!char_pos[$o - 1]) / 2).Int, 1,
                                         (($!char_pos[$o + 2] + $!char_pos[$o + 1]) / 2 - ($!char_pos[$o] + $!char_pos[$o - 1]) / 2).Int, self.h - 1 );
            my $dstrect = SDL::Rect.new( ($x - ($!char_pos[$o] - $!char_pos[$o - 1]) / 2).Int, $y, 0, 0 );

            self.surface.blit($target, $srcrect, $dstrect); 

            $x += $!char_pos[$o + 1] - $!char_pos[$o];
        }
        $i++;
    }
}
