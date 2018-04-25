use SDL;
use Test;

plan 11;

SDL_Linked_Version() andthen diag sprintf 'SDL_Linked_Version v%d.%d.%d', .major, .minor, .patch;

is SDL_Init(1),                 0, "SDL_Init";
is SDL_WasInit(0),              1, "SDL_WasInit";
is SDL_InitSubSystem(255),      0, "SDL_InitSubSystem";
ok SDL_WasInit(0) > 1,             "SDL_WasInit";
SDL_QuitSubSystem(254);       pass "SDL_QuitSubSystem";
is SDL_WasInit(0),              1, "SDL_WasInit";

SDL_Delay(200);
ok SDL_GetTicks() >= 200,          "SDL_GetTicks";

my $version = SDL_Linked_Version();
isa-ok $version,      SDL_version, "SDL_Linked_Version";
is $version.major,              1, "SDL_Linked_Version.major";
is $version.minor,              2, "SDL_Linked_Version.minor";
ok 4 <= $version.patch <= 15,      "SDL_Linked_Version.patch";
