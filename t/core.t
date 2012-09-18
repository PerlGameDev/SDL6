#!/usr/bin/env perl6

use lib 'lib';
use SDL;
use Test;

plan 12;

is SDL::init( 1 ),               0, "SDL::init";
is SDL::was_init( 0 ),           1, "SDL::was_init";
is SDL::init_subsystem( 255 ),   0, "SDL::init_subsystem";
ok SDL::was_init( 0 ) > 1,          "SDL::was_init";
SDL::quit_subsystem( 254 ),    pass "SDL::quit_subsystem";
is SDL::was_init( 0 ),           1, "SDL::was_init";

SDL::delay( 200 );
ok SDL::get_ticks( ) => 200,        "SDL::delay";
ok SDL::get_ticks( ) => 200,        "SDL::get_ticks";

my $version = SDL::linked_version( );
isa_ok $version,    'SDL::Version', "SDL::linked_version";
is $version.major,               1, "SDL::linked_version.major";
is $version.minor,               2, "SDL::linked_version.minor";
ok 4 <= $version.patch <= 15,       "SDL::linked_version.patch";

SDL::rw_from_file( 'sample.wav', 'rb' );
