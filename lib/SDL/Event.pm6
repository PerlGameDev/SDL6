
module SDL::Event;

use NativeCall; # for CArray type

class SDL::Event {
	has Int $.type is rw;
	has Int $.active_type is rw;
	has Int $.active_gaine is rw;
	has Int $.active_state is rw;
#  SDL_KeyboardEvent key;
#  SDL_MouseMotionEvent motion;
#  SDL_MouseButtonEvent button;
#  SDL_JoyAxisEvent jaxis;
#  SDL_JoyBallEvent jball;
#  SDL_JoyHatEvent jhat;
#  SDL_JoyButtonEvent jbutton;
#  SDL_ResizeEvent resize;
#  SDL_ExposeEvent expose;
#  SDL_QuitEvent quit;
#  SDL_UserEvent user;
#  SDL_SysWMEvent syswm; is rw;

	my $carr = CArray[int].new();

	method CArray {
		$carr[0] = 0;
		$carr[1] = 0;
		$carr[2] = 0;
		$carr[3] = 0;
		$carr[4] = 0;
		$carr[5] = 0;
		$carr
	}

	method poll {
		_poll_event( self.CArray )
	}

	method type          {  $carr[0]        +& 0xFF;   }
	method key_state     { ($carr[0] +> 16) +& 0xFF;   }
	method key_sym       {  $carr[1]        +& 0xFF;   }
	method button_button { ($carr[0] +> 16) +& 0xFF;   }
	method button_x      { ($carr[0] +> 32) +& 0xFFFF; }
	method button_y      { ($carr[0] +> 48) +& 0xFFFF; }

	method dump {
		printf( "%X\n", $carr[0] );
		printf( "%X\n", $carr[1] );
		printf( "%X\n", $carr[2] );
		printf( "%X\n", $carr[3] );
		printf( "%X\n", $carr[4] );
		printf( "%X\n\n", $carr[5] );
	}
}

our sub _poll_event( CArray[int] )  returns Int  is native('libSDL')  is symbol('SDL_PollEvent')  { * }

#24
#3
#20
#12
#8
#6
#8
#4
#4
#12
#1
#1
#24
#16

# SDL::Events/type
constant SDL_ACTIVEEVENT     = 1;
constant SDL_KEYDOWN         = 2;
constant SDL_KEYUP           = 3;
constant SDL_MOUSEMOTION     = 4;
constant SDL_MOUSEBUTTONDOWN = 5;
constant SDL_MOUSEBUTTONUP   = 6;
constant SDL_JOYAXISMOTION   = 7;
constant SDL_JOYBALLMOTION   = 8;
constant SDL_JOYHATMOTION    = 9;
constant SDL_JOYBUTTONDOWN   = 10;
constant SDL_JOYBUTTONUP     = 11;
constant SDL_QUIT            = 12;
constant SDL_SYSWMEVENT      = 13;
constant SDL_VIDEORESIZE     = 16;
constant SDL_VIDEOEXPOSE     = 17;
constant SDL_USEREVENT       = 24;
constant SDL_NUMEVENTS       = 32;

sub SDL_EVENTMASK (Int $a) { return 1 +< $a; }

# SDL::Events/mask
constant SDL_ACTIVEEVENTMASK     = SDL_EVENTMASK(SDL_ACTIVEEVENT);
constant SDL_KEYDOWNMASK         = SDL_EVENTMASK(SDL_KEYDOWN);
constant SDL_KEYUPMASK           = SDL_EVENTMASK(SDL_KEYUP);
constant SDL_KEYEVENTMASK        = SDL_EVENTMASK(SDL_KEYDOWN) +| SDL_EVENTMASK(SDL_KEYUP);
constant SDL_MOUSEMOTIONMASK     = SDL_EVENTMASK(SDL_MOUSEMOTION);
constant SDL_MOUSEBUTTONDOWNMASK = SDL_EVENTMASK(SDL_MOUSEBUTTONDOWN);
constant SDL_MOUSEBUTTONUPMASK   = SDL_EVENTMASK(SDL_MOUSEBUTTONUP);
constant SDL_MOUSEEVENTMASK      = SDL_EVENTMASK(SDL_MOUSEMOTION) +| SDL_EVENTMASK(SDL_MOUSEBUTTONDOWN) +| SDL_EVENTMASK(SDL_MOUSEBUTTONUP);
constant SDL_JOYAXISMOTIONMASK   = SDL_EVENTMASK(SDL_JOYAXISMOTION);
constant SDL_JOYBALLMOTIONMASK   = SDL_EVENTMASK(SDL_JOYBALLMOTION);
constant SDL_JOYHATMOTIONMASK    = SDL_EVENTMASK(SDL_JOYHATMOTION);
constant SDL_JOYBUTTONDOWNMASK   = SDL_EVENTMASK(SDL_JOYBUTTONDOWN);
constant SDL_JOYBUTTONUPMASK     = SDL_EVENTMASK(SDL_JOYBUTTONUP);
constant SDL_JOYEVENTMASK        = SDL_EVENTMASK(SDL_JOYAXISMOTION) +| SDL_EVENTMASK(SDL_JOYBALLMOTION) +| SDL_EVENTMASK(SDL_JOYHATMOTION) +|
                                   SDL_EVENTMASK(SDL_JOYBUTTONDOWN) +| SDL_EVENTMASK(SDL_JOYBUTTONUP);
constant SDL_VIDEORESIZEMASK     = SDL_EVENTMASK(SDL_VIDEORESIZE);
constant SDL_VIDEOEXPOSEMASK     = SDL_EVENTMASK(SDL_VIDEOEXPOSE);
constant SDL_QUITMASK            = SDL_EVENTMASK(SDL_QUIT);
constant SDL_SYSWMEVENTMASK      = SDL_EVENTMASK(SDL_SYSWMEVENT);
constant SDL_ALLEVENTS           = 0xFFFFFFFF;

# SDL::Events/action
constant SDL_ADDEVENT  = 0;
constant SDL_PEEKEVENT = 1;
constant SDL_GETEVENT  = 2;

# SDL::Events/state
constant SDL_QUERY    = -1;
constant SDL_IGNORE   = 0;
constant SDL_DISABLE  = 0;
constant SDL_ENABLE   = 1;
constant SDL_RELEASED = 0;
constant SDL_PRESSED  = 1;

# SDL::Events/hat
constant SDL_HAT_CENTERED  = 0x00;
constant SDL_HAT_UP        = 0x01;
constant SDL_HAT_RIGHT     = 0x02;
constant SDL_HAT_DOWN      = 0x04;
constant SDL_HAT_LEFT      = 0x08;
constant SDL_HAT_RIGHTUP   = 0x02 +| 0x01;
constant SDL_HAT_RIGHTDOWN = 0x02 +| 0x04;
constant SDL_HAT_LEFTUP    = 0x08 +| 0x01;
constant SDL_HAT_LEFTDOWN  = 0x08 +| 0x04;

# SDL::Events/app
constant SDL_APPMOUSEFOCUS = 0x01;
constant SDL_APPINPUTFOCUS = 0x02;
constant SDL_APPACTIVE     = 0x04;

sub SDL_BUTTON ( Int $a) { return 1 +< ( $a - 1 ) }

# SDL::Events/button
constant SDL_BUTTON_LEFT      = 1;
constant SDL_BUTTON_MIDDLE    = 2;
constant SDL_BUTTON_RIGHT     = 3;
constant SDL_BUTTON_WHEELUP   = 4;
constant SDL_BUTTON_WHEELDOWN = 5;
constant SDL_BUTTON_X1        = 6;
constant SDL_BUTTON_X2        = 7;
constant SDL_BUTTON_LMASK     = SDL_BUTTON(1);
constant SDL_BUTTON_MMASK     = SDL_BUTTON(2);
constant SDL_BUTTON_RMASK     = SDL_BUTTON(3);
constant SDL_BUTTON_X1MASK    = SDL_BUTTON(6);
constant SDL_BUTTON_X2MASK    = SDL_BUTTON(7);

# SDL::Events/keysym
constant SDLK_UNKNOWN      = 0;
constant SDLK_FIRST        = 0;
constant SDLK_BACKSPACE    = 8;
constant SDLK_TAB          = 9;
constant SDLK_CLEAR        = 12;
constant SDLK_RETURN       = 13;
constant SDLK_PAUSE        = 19;
constant SDLK_ESCAPE       = 27;
constant SDLK_SPACE        = 32;
constant SDLK_EXCLAIM      = 33;
constant SDLK_QUOTEDBL     = 34;
constant SDLK_HASH         = 35;
constant SDLK_DOLLAR       = 36;
constant SDLK_AMPERSAND    = 38;
constant SDLK_QUOTE        = 39;
constant SDLK_LEFTPAREN    = 40;
constant SDLK_RIGHTPAREN   = 41;
constant SDLK_ASTERISK     = 42;
constant SDLK_PLUS         = 43;
constant SDLK_COMMA        = 44;
constant SDLK_MINUS        = 45;
constant SDLK_PERIOD       = 46;
constant SDLK_SLASH        = 47;
constant SDLK_0            = 48;
constant SDLK_1            = 49;
constant SDLK_2            = 50;
constant SDLK_3            = 51;
constant SDLK_4            = 52;
constant SDLK_5            = 53;
constant SDLK_6            = 54;
constant SDLK_7            = 55;
constant SDLK_8            = 56;
constant SDLK_9            = 57;
constant SDLK_COLON        = 58;
constant SDLK_SEMICOLON    = 59;
constant SDLK_LESS         = 60;
constant SDLK_EQUALS       = 61;
constant SDLK_GREATER      = 62;
constant SDLK_QUESTION     = 63;
constant SDLK_AT           = 64;
constant SDLK_LEFTBRACKET  = 91;
constant SDLK_BACKSLASH    = 92;
constant SDLK_RIGHTBRACKET = 93;
constant SDLK_CARET        = 94;
constant SDLK_UNDERSCORE   = 95;
constant SDLK_BACKQUOTE    = 96;
constant SDLK_a            = 97;
constant SDLK_b            = 98;
constant SDLK_c            = 99;
constant SDLK_d            = 100;
constant SDLK_e            = 101;
constant SDLK_f            = 102;
constant SDLK_g            = 103;
constant SDLK_h            = 104;
constant SDLK_i            = 105;
constant SDLK_j            = 106;
constant SDLK_k            = 107;
constant SDLK_l            = 108;
constant SDLK_m            = 109;
constant SDLK_n            = 110;
constant SDLK_o            = 111;
constant SDLK_p            = 112;
constant SDLK_q            = 113;
constant SDLK_r            = 114;
constant SDLK_s            = 115;
constant SDLK_t            = 116;
constant SDLK_u            = 117;
constant SDLK_v            = 118;
constant SDLK_w            = 119;
constant SDLK_x            = 120;
constant SDLK_y            = 121;
constant SDLK_z            = 122;
constant SDLK_DELETE       = 127;
constant SDLK_WORLD_0      = 160;
constant SDLK_WORLD_1      = 161;
constant SDLK_WORLD_2      = 162;
constant SDLK_WORLD_3      = 163;
constant SDLK_WORLD_4      = 164;
constant SDLK_WORLD_5      = 165;
constant SDLK_WORLD_6      = 166;
constant SDLK_WORLD_7      = 167;
constant SDLK_WORLD_8      = 168;
constant SDLK_WORLD_9      = 169;
constant SDLK_WORLD_10     = 170;
constant SDLK_WORLD_11     = 171;
constant SDLK_WORLD_12     = 172;
constant SDLK_WORLD_13     = 173;
constant SDLK_WORLD_14     = 174;
constant SDLK_WORLD_15     = 175;
constant SDLK_WORLD_16     = 176;
constant SDLK_WORLD_17     = 177;
constant SDLK_WORLD_18     = 178;
constant SDLK_WORLD_19     = 179;
constant SDLK_WORLD_20     = 180;
constant SDLK_WORLD_21     = 181;
constant SDLK_WORLD_22     = 182;
constant SDLK_WORLD_23     = 183;
constant SDLK_WORLD_24     = 184;
constant SDLK_WORLD_25     = 185;
constant SDLK_WORLD_26     = 186;
constant SDLK_WORLD_27     = 187;
constant SDLK_WORLD_28     = 188;
constant SDLK_WORLD_29     = 189;
constant SDLK_WORLD_30     = 190;
constant SDLK_WORLD_31     = 191;
constant SDLK_WORLD_32     = 192;
constant SDLK_WORLD_33     = 193;
constant SDLK_WORLD_34     = 194;
constant SDLK_WORLD_35     = 195;
constant SDLK_WORLD_36     = 196;
constant SDLK_WORLD_37     = 197;
constant SDLK_WORLD_38     = 198;
constant SDLK_WORLD_39     = 199;
constant SDLK_WORLD_40     = 200;
constant SDLK_WORLD_41     = 201;
constant SDLK_WORLD_42     = 202;
constant SDLK_WORLD_43     = 203;
constant SDLK_WORLD_44     = 204;
constant SDLK_WORLD_45     = 205;
constant SDLK_WORLD_46     = 206;
constant SDLK_WORLD_47     = 207;
constant SDLK_WORLD_48     = 208;
constant SDLK_WORLD_49     = 209;
constant SDLK_WORLD_50     = 210;
constant SDLK_WORLD_51     = 211;
constant SDLK_WORLD_52     = 212;
constant SDLK_WORLD_53     = 213;
constant SDLK_WORLD_54     = 214;
constant SDLK_WORLD_55     = 215;
constant SDLK_WORLD_56     = 216;
constant SDLK_WORLD_57     = 217;
constant SDLK_WORLD_58     = 218;
constant SDLK_WORLD_59     = 219;
constant SDLK_WORLD_60     = 220;
constant SDLK_WORLD_61     = 221;
constant SDLK_WORLD_62     = 222;
constant SDLK_WORLD_63     = 223;
constant SDLK_WORLD_64     = 224;
constant SDLK_WORLD_65     = 225;
constant SDLK_WORLD_66     = 226;
constant SDLK_WORLD_67     = 227;
constant SDLK_WORLD_68     = 228;
constant SDLK_WORLD_69     = 229;
constant SDLK_WORLD_70     = 230;
constant SDLK_WORLD_71     = 231;
constant SDLK_WORLD_72     = 232;
constant SDLK_WORLD_73     = 233;
constant SDLK_WORLD_74     = 234;
constant SDLK_WORLD_75     = 235;
constant SDLK_WORLD_76     = 236;
constant SDLK_WORLD_77     = 237;
constant SDLK_WORLD_78     = 238;
constant SDLK_WORLD_79     = 239;
constant SDLK_WORLD_80     = 240;
constant SDLK_WORLD_81     = 241;
constant SDLK_WORLD_82     = 242;
constant SDLK_WORLD_83     = 243;
constant SDLK_WORLD_84     = 244;
constant SDLK_WORLD_85     = 245;
constant SDLK_WORLD_86     = 246;
constant SDLK_WORLD_87     = 247;
constant SDLK_WORLD_88     = 248;
constant SDLK_WORLD_89     = 249;
constant SDLK_WORLD_90     = 250;
constant SDLK_WORLD_91     = 251;
constant SDLK_WORLD_92     = 252;
constant SDLK_WORLD_93     = 253;
constant SDLK_WORLD_94     = 254;
constant SDLK_WORLD_95     = 255;
constant SDLK_KP0          = 256;
constant SDLK_KP1          = 257;
constant SDLK_KP2          = 258;
constant SDLK_KP3          = 259;
constant SDLK_KP4          = 260;
constant SDLK_KP5          = 261;
constant SDLK_KP6          = 262;
constant SDLK_KP7          = 263;
constant SDLK_KP8          = 264;
constant SDLK_KP9          = 265;
constant SDLK_KP_PERIOD    = 266;
constant SDLK_KP_DIVIDE    = 267;
constant SDLK_KP_MULTIPLY  = 268;
constant SDLK_KP_MINUS     = 269;
constant SDLK_KP_PLUS      = 270;
constant SDLK_KP_ENTER     = 271;
constant SDLK_KP_EQUALS    = 272;
constant SDLK_UP           = 273;
constant SDLK_DOWN         = 274;
constant SDLK_RIGHT        = 275;
constant SDLK_LEFT         = 276;
constant SDLK_INSERT       = 277;
constant SDLK_HOME         = 278;
constant SDLK_END          = 279;
constant SDLK_PAGEUP       = 280;
constant SDLK_PAGEDOWN     = 281;
constant SDLK_F1           = 282;
constant SDLK_F2           = 283;
constant SDLK_F3           = 284;
constant SDLK_F4           = 285;
constant SDLK_F5           = 286;
constant SDLK_F6           = 287;
constant SDLK_F7           = 288;
constant SDLK_F8           = 289;
constant SDLK_F9           = 290;
constant SDLK_F10          = 291;
constant SDLK_F11          = 292;
constant SDLK_F12          = 293;
constant SDLK_F13          = 294;
constant SDLK_F14          = 295;
constant SDLK_F15          = 296;
constant SDLK_NUMLOCK      = 300;
constant SDLK_CAPSLOCK     = 301;
constant SDLK_SCROLLOCK    = 302;
constant SDLK_RSHIFT       = 303;
constant SDLK_LSHIFT       = 304;
constant SDLK_RCTRL        = 305;
constant SDLK_LCTRL        = 306;
constant SDLK_RALT         = 307;
constant SDLK_LALT         = 308;
constant SDLK_RMETA        = 309;
constant SDLK_LMETA        = 310;
constant SDLK_LSUPER       = 311;
constant SDLK_RSUPER       = 312;
constant SDLK_MODE         = 313;
constant SDLK_COMPOSE      = 314;
constant SDLK_HELP         = 315;
constant SDLK_PRINT        = 316;
constant SDLK_SYSREQ       = 317;
constant SDLK_BREAK        = 318;
constant SDLK_MENU         = 319;
constant SDLK_POWER        = 320;
constant SDLK_EURO         = 321;
constant SDLK_UNDO         = 322;

# SDL::Events/keymod
constant KMOD_NONE     = 0x0000;
constant KMOD_LSHIFT   = 0x0001;
constant KMOD_RSHIFT   = 0x0002;
constant KMOD_LCTRL    = 0x0040;
constant KMOD_RCTRL    = 0x0080;
constant KMOD_LALT     = 0x0100;
constant KMOD_RALT     = 0x0200;
constant KMOD_LMETA    = 0x0400;
constant KMOD_RMETA    = 0x0800;
constant KMOD_NUM      = 0x1000;
constant KMOD_CAPS     = 0x2000;
constant KMOD_MODE     = 0x4000;
constant KMOD_RESERVED = 0x8000;

# SDL::Events/keymod
constant KMOD_CTRL  = KMOD_LCTRL  +| KMOD_RCTRL;
constant KMOD_SHIFT = KMOD_LSHIFT +| KMOD_RSHIFT;
constant KMOD_ALT   = KMOD_LALT   +| KMOD_RALT;
constant KMOD_META  = KMOD_LMETA  +| KMOD_RMETA;

# SDL::Events/repeat
constant SDL_DEFAULT_REPEAT_DELAY    = 500;
constant SDL_DEFAULT_REPEAT_INTERVAL = 30;

1;
