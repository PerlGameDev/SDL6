use v6;
use SDL::Constants;
use SDL::Structures;
use SDL::Functions;

sub EXPORT { %(
    SDL::Constants::EXPORT::DEFAULT::,
    SDL::Structures::EXPORT::DEFAULT::,
    SDL::Functions::EXPORT::DEFAULT::,
) }
