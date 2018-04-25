use SDL;
use Test;

plan 9;

SDL_Linked_Version() andthen diag sprintf 'v%d.%d.%d', .major, .minor, .patch;

my $r1 = SDL_Rect.new(1, 2, 3, 4);
my $r2 = SDL_Rect.new(4, 3, 2, 1);

ok $r1 ~~ SDL_Rect, 'create a SDL::Rect object';
is $r1.x, 1, 'rect one attribute x';
is $r1.y, 2, 'rect one attribute y';
is $r1.w, 3, 'rect one attribute w';
is $r1.h, 4, 'rect one attribute h';
is $r2.x, 4, 'rect two attribute x';
is $r2.y, 3, 'rect two attribute y';
is $r2.w, 2, 'rect two attribute w';
is $r2.h, 1, 'rect two attribute h';
