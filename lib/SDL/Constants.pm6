unit module SDL::Constants;

enum SDL::Constants::Init is export (
    SDL_INIT_TIMER       => 0x00000001,
    SDL_INIT_AUDIO       => 0x00000010,
    SDL_INIT_VIDEO       => 0x00000020,
    SDL_INIT_CDROM       => 0x00000100,
    SDL_INIT_JOYSTICK    => 0x00000200,
    SDL_INIT_NOPARACHUTE => 0x00100000,
    SDL_INIT_EVENTTHREAD => 0x01000000,
    SDL_INIT_EVERYTHING  => 0x0000FFFF,
); # SDL/init

enum SDL::Constants::Defaults is export (
    SDL_LIL_ENDIAN => 1234,
    SDL_BIG_ENDIAN => 4321,
    #~ SDL_BYTEORDER  => $Config{byteorder}
); # SDL/defaults

enum SDL::Constants::AudioFormat is export (
    AUDIO_U8     => 0x0008,
    AUDIO_S8     => 0x8008,
    AUDIO_U16LSB => 0x0010,
    AUDIO_S16LSB => 0x8010,
    AUDIO_U16MSB => 0x1010,
    AUDIO_S16MSB => 0x9010,
    AUDIO_U16    => 0x0010,
    AUDIO_S16    => 0x8010,
	#~ AUDIO_U16SYS => ( $Config{byteorder} == 1234 ? 0x0010 : 0x1010 ),
	#~ AUDIO_S16SYS => ( $Config{byteorder} == 1234 ? 0x8010 : 0x9010 ),
); # SDL::Audio/format

enum SDL::Constants::AudioStatus is export (
    SDL_AUDIO_STOPPED => 0,
    SDL_AUDIO_PLAYING => 1,
    SDL_AUDIO_PAUSED  => 2,
); # SDL::Audio/status

enum SDL::Constants::CDROMDefaults is export (
    CD_FPS         => 75,
    SDL_MAX_TRACKS => 99,
); # SDL::CDROM/defaults

enum SDL::Constants::CDROMStatus is export (
    CD_TRAYEMPTY => 0,
    CD_STOPPED   => 1,
    CD_PLAYING   => 2,
    CD_PAUSED    => 3,
    CD_ERROR     => -1,
); # SDL::CDROM/status

enum SDL::Constants::CDROMTrackType is export (
    SDL_AUDIO_TRACK => 0,
    SDL_DATA_TRACK  => 4,
); # SDL::CDROM/track_type

enum SDL::Constants::EventType is export (
    SDL_ACTIVEEVENT     => 1,
    SDL_KEYDOWN         => 2,
    SDL_KEYUP           => 3,
    SDL_MOUSEMOTION     => 4,
    SDL_MOUSEBUTTONDOWN => 5,
    SDL_MOUSEBUTTONUP   => 6,
    SDL_JOYAXISMOTION   => 7,
    SDL_JOYBALLMOTION   => 8,
    SDL_JOYHATMOTION    => 9,
    SDL_JOYBUTTONDOWN   => 10,
    SDL_JOYBUTTONUP     => 11,
    SDL_QUIT            => 12,
    SDL_SYSWMEVENT      => 13,
    SDL_VIDEORESIZE     => 16,
    SDL_VIDEOEXPOSE     => 17,
    SDL_USEREVENT       => 24,
    SDL_NUMEVENTS       => 32,
); # SDL::Event/type

sub SDL_EVENTMASK($e) { return 1 +< $e; }

enum SDL::Constants::EventMask is export (
    SDL_ACTIVEEVENTMASK     => SDL_EVENTMASK(SDL_ACTIVEEVENT),
    SDL_KEYDOWNMASK         => SDL_EVENTMASK(SDL_KEYDOWN),
    SDL_KEYUPMASK           => SDL_EVENTMASK(SDL_KEYUP),
    SDL_KEYEVENTMASK        => SDL_EVENTMASK(SDL_KEYDOWN)
                            +| SDL_EVENTMASK(SDL_KEYUP),
    SDL_MOUSEMOTIONMASK     => SDL_EVENTMASK(SDL_MOUSEMOTION),
    SDL_MOUSEBUTTONDOWNMASK => SDL_EVENTMASK(SDL_MOUSEBUTTONDOWN),
    SDL_MOUSEBUTTONUPMASK   => SDL_EVENTMASK(SDL_MOUSEBUTTONUP),
    SDL_MOUSEEVENTMASK      => SDL_EVENTMASK(SDL_MOUSEMOTION)
                            +| SDL_EVENTMASK(SDL_MOUSEBUTTONDOWN)
                            +| SDL_EVENTMASK(SDL_MOUSEBUTTONUP),
    SDL_JOYAXISMOTIONMASK   => SDL_EVENTMASK(SDL_JOYAXISMOTION),
    SDL_JOYBALLMOTIONMASK   => SDL_EVENTMASK(SDL_JOYBALLMOTION),
    SDL_JOYHATMOTIONMASK    => SDL_EVENTMASK(SDL_JOYHATMOTION),
    SDL_JOYBUTTONDOWNMASK   => SDL_EVENTMASK(SDL_JOYBUTTONDOWN),
    SDL_JOYBUTTONUPMASK     => SDL_EVENTMASK(SDL_JOYBUTTONUP),
    SDL_JOYEVENTMASK        => SDL_EVENTMASK(SDL_JOYAXISMOTION)
                            +| SDL_EVENTMASK(SDL_JOYBALLMOTION)
                            +| SDL_EVENTMASK(SDL_JOYHATMOTION)
                            +| SDL_EVENTMASK(SDL_JOYBUTTONDOWN)
                            +| SDL_EVENTMASK(SDL_JOYBUTTONUP),
    SDL_VIDEORESIZEMASK     => SDL_EVENTMASK(SDL_VIDEORESIZE),
    SDL_VIDEOEXPOSEMASK     => SDL_EVENTMASK(SDL_VIDEOEXPOSE),
    SDL_QUITMASK            => SDL_EVENTMASK(SDL_QUIT),
    SDL_SYSWMEVENTMASK      => SDL_EVENTMASK(SDL_SYSWMEVENT),
    SDL_ALLEVENTS           => 0xFFFFFFFF,
);

enum SDL::Constants::EventAction is export (
    SDL_ADDEVENT  => 0,
    SDL_PEEKEVENT => 1,
    SDL_GETEVENT  => 2,
); # SDL::Events/action

enum SDL::Constants::EventState is export (
    SDL_QUERY    => -1,
    SDL_IGNORE   => 0,
    SDL_DISABLE  => 0,
    SDL_ENABLE   => 1,
    SDL_RELEASED => 0,
    SDL_PRESSED  => 1,
); # SDL::Events/state

enum SDL::Constants::EventHat is export (
    SDL_HAT_CENTERED  => 0x00,
    SDL_HAT_UP        => 0x01,
    SDL_HAT_RIGHT     => 0x02,
    SDL_HAT_DOWN      => 0x04,
    SDL_HAT_LEFT      => 0x08,
    SDL_HAT_RIGHTUP   => 0x02 +| 0x01,
    SDL_HAT_RIGHTDOWN => 0x02 +| 0x04,
    SDL_HAT_LEFTUP    => 0x08 +| 0x01,
    SDL_HAT_LEFTDOWN  => 0x08 +| 0x04,
); # SDL::Events/hat

enum SDL::Constants::EventApp is export (
    SDL_APPMOUSEFOCUS => 0x01,
    SDL_APPINPUTFOCUS => 0x02,
    SDL_APPACTIVE     => 0x04,
); # SDL::Events/app

sub SDL_BUTTON($b) { return (1 +< ($b - 1)); }

enum SDL::Constants::EventButton is export (
    SDL_BUTTON_LEFT      => 1,
    SDL_BUTTON_MIDDLE    => 2,
    SDL_BUTTON_RIGHT     => 3,
    SDL_BUTTON_WHEELUP   => 4,
    SDL_BUTTON_WHEELDOWN => 5,
    SDL_BUTTON_X1        => 6,
    SDL_BUTTON_X2        => 7,
    SDL_BUTTON_LMASK     => SDL_BUTTON(1),
    SDL_BUTTON_MMASK     => SDL_BUTTON(2),
    SDL_BUTTON_RMASK     => SDL_BUTTON(3),
    SDL_BUTTON_X1MASK    => SDL_BUTTON(6),
    SDL_BUTTON_X2MASK    => SDL_BUTTON(7),
); # SDL::Events/button

enum SDL::Constants::EventKeysym is export (
    SDLK_UNKNOWN      => 0,
    SDLK_FIRST        => 0,
    SDLK_BACKSPACE    => 8,
    SDLK_TAB          => 9,
    SDLK_CLEAR        => 12,
    SDLK_RETURN       => 13,
    SDLK_PAUSE        => 19,
    SDLK_ESCAPE       => 27,
    SDLK_SPACE        => 32,
    SDLK_EXCLAIM      => 33,
    SDLK_QUOTEDBL     => 34,
    SDLK_HASH         => 35,
    SDLK_DOLLAR       => 36,
    SDLK_AMPERSAND    => 38,
    SDLK_QUOTE        => 39,
    SDLK_LEFTPAREN    => 40,
    SDLK_RIGHTPAREN   => 41,
    SDLK_ASTERISK     => 42,
    SDLK_PLUS         => 43,
    SDLK_COMMA        => 44,
    SDLK_MINUS        => 45,
    SDLK_PERIOD       => 46,
    SDLK_SLASH        => 47,
    SDLK_0            => 48,
    SDLK_1            => 49,
    SDLK_2            => 50,
    SDLK_3            => 51,
    SDLK_4            => 52,
    SDLK_5            => 53,
    SDLK_6            => 54,
    SDLK_7            => 55,
    SDLK_8            => 56,
    SDLK_9            => 57,
    SDLK_COLON        => 58,
    SDLK_SEMICOLON    => 59,
    SDLK_LESS         => 60,
    SDLK_EQUALS       => 61,
    SDLK_GREATER      => 62,
    SDLK_QUESTION     => 63,
    SDLK_AT           => 64,
    SDLK_LEFTBRACKET  => 91,
    SDLK_BACKSLASH    => 92,
    SDLK_RIGHTBRACKET => 93,
    SDLK_CARET        => 94,
    SDLK_UNDERSCORE   => 95,
    SDLK_BACKQUOTE    => 96,
    SDLK_a            => 97,
    SDLK_b            => 98,
    SDLK_c            => 99,
    SDLK_d            => 100,
    SDLK_e            => 101,
    SDLK_f            => 102,
    SDLK_g            => 103,
    SDLK_h            => 104,
    SDLK_i            => 105,
    SDLK_j            => 106,
    SDLK_k            => 107,
    SDLK_l            => 108,
    SDLK_m            => 109,
    SDLK_n            => 110,
    SDLK_o            => 111,
    SDLK_p            => 112,
    SDLK_q            => 113,
    SDLK_r            => 114,
    SDLK_s            => 115,
    SDLK_t            => 116,
    SDLK_u            => 117,
    SDLK_v            => 118,
    SDLK_w            => 119,
    SDLK_x            => 120,
    SDLK_y            => 121,
    SDLK_z            => 122,
    SDLK_DELETE       => 127,
    SDLK_WORLD_0      => 160,
    SDLK_WORLD_1      => 161,
    SDLK_WORLD_2      => 162,
    SDLK_WORLD_3      => 163,
    SDLK_WORLD_4      => 164,
    SDLK_WORLD_5      => 165,
    SDLK_WORLD_6      => 166,
    SDLK_WORLD_7      => 167,
    SDLK_WORLD_8      => 168,
    SDLK_WORLD_9      => 169,
    SDLK_WORLD_10     => 170,
    SDLK_WORLD_11     => 171,
    SDLK_WORLD_12     => 172,
    SDLK_WORLD_13     => 173,
    SDLK_WORLD_14     => 174,
    SDLK_WORLD_15     => 175,
    SDLK_WORLD_16     => 176,
    SDLK_WORLD_17     => 177,
    SDLK_WORLD_18     => 178,
    SDLK_WORLD_19     => 179,
    SDLK_WORLD_20     => 180,
    SDLK_WORLD_21     => 181,
    SDLK_WORLD_22     => 182,
    SDLK_WORLD_23     => 183,
    SDLK_WORLD_24     => 184,
    SDLK_WORLD_25     => 185,
    SDLK_WORLD_26     => 186,
    SDLK_WORLD_27     => 187,
    SDLK_WORLD_28     => 188,
    SDLK_WORLD_29     => 189,
    SDLK_WORLD_30     => 190,
    SDLK_WORLD_31     => 191,
    SDLK_WORLD_32     => 192,
    SDLK_WORLD_33     => 193,
    SDLK_WORLD_34     => 194,
    SDLK_WORLD_35     => 195,
    SDLK_WORLD_36     => 196,
    SDLK_WORLD_37     => 197,
    SDLK_WORLD_38     => 198,
    SDLK_WORLD_39     => 199,
    SDLK_WORLD_40     => 200,
    SDLK_WORLD_41     => 201,
    SDLK_WORLD_42     => 202,
    SDLK_WORLD_43     => 203,
    SDLK_WORLD_44     => 204,
    SDLK_WORLD_45     => 205,
    SDLK_WORLD_46     => 206,
    SDLK_WORLD_47     => 207,
    SDLK_WORLD_48     => 208,
    SDLK_WORLD_49     => 209,
    SDLK_WORLD_50     => 210,
    SDLK_WORLD_51     => 211,
    SDLK_WORLD_52     => 212,
    SDLK_WORLD_53     => 213,
    SDLK_WORLD_54     => 214,
    SDLK_WORLD_55     => 215,
    SDLK_WORLD_56     => 216,
    SDLK_WORLD_57     => 217,
    SDLK_WORLD_58     => 218,
    SDLK_WORLD_59     => 219,
    SDLK_WORLD_60     => 220,
    SDLK_WORLD_61     => 221,
    SDLK_WORLD_62     => 222,
    SDLK_WORLD_63     => 223,
    SDLK_WORLD_64     => 224,
    SDLK_WORLD_65     => 225,
    SDLK_WORLD_66     => 226,
    SDLK_WORLD_67     => 227,
    SDLK_WORLD_68     => 228,
    SDLK_WORLD_69     => 229,
    SDLK_WORLD_70     => 230,
    SDLK_WORLD_71     => 231,
    SDLK_WORLD_72     => 232,
    SDLK_WORLD_73     => 233,
    SDLK_WORLD_74     => 234,
    SDLK_WORLD_75     => 235,
    SDLK_WORLD_76     => 236,
    SDLK_WORLD_77     => 237,
    SDLK_WORLD_78     => 238,
    SDLK_WORLD_79     => 239,
    SDLK_WORLD_80     => 240,
    SDLK_WORLD_81     => 241,
    SDLK_WORLD_82     => 242,
    SDLK_WORLD_83     => 243,
    SDLK_WORLD_84     => 244,
    SDLK_WORLD_85     => 245,
    SDLK_WORLD_86     => 246,
    SDLK_WORLD_87     => 247,
    SDLK_WORLD_88     => 248,
    SDLK_WORLD_89     => 249,
    SDLK_WORLD_90     => 250,
    SDLK_WORLD_91     => 251,
    SDLK_WORLD_92     => 252,
    SDLK_WORLD_93     => 253,
    SDLK_WORLD_94     => 254,
    SDLK_WORLD_95     => 255,
    SDLK_KP0          => 256,
    SDLK_KP1          => 257,
    SDLK_KP2          => 258,
    SDLK_KP3          => 259,
    SDLK_KP4          => 260,
    SDLK_KP5          => 261,
    SDLK_KP6          => 262,
    SDLK_KP7          => 263,
    SDLK_KP8          => 264,
    SDLK_KP9          => 265,
    SDLK_KP_PERIOD    => 266,
    SDLK_KP_DIVIDE    => 267,
    SDLK_KP_MULTIPLY  => 268,
    SDLK_KP_MINUS     => 269,
    SDLK_KP_PLUS      => 270,
    SDLK_KP_ENTER     => 271,
    SDLK_KP_EQUALS    => 272,
    SDLK_UP           => 273,
    SDLK_DOWN         => 274,
    SDLK_RIGHT        => 275,
    SDLK_LEFT         => 276,
    SDLK_INSERT       => 277,
    SDLK_HOME         => 278,
    SDLK_END          => 279,
    SDLK_PAGEUP       => 280,
    SDLK_PAGEDOWN     => 281,
    SDLK_F1           => 282,
    SDLK_F2           => 283,
    SDLK_F3           => 284,
    SDLK_F4           => 285,
    SDLK_F5           => 286,
    SDLK_F6           => 287,
    SDLK_F7           => 288,
    SDLK_F8           => 289,
    SDLK_F9           => 290,
    SDLK_F10          => 291,
    SDLK_F11          => 292,
    SDLK_F12          => 293,
    SDLK_F13          => 294,
    SDLK_F14          => 295,
    SDLK_F15          => 296,
    SDLK_NUMLOCK      => 300,
    SDLK_CAPSLOCK     => 301,
    SDLK_SCROLLOCK    => 302,
    SDLK_RSHIFT       => 303,
    SDLK_LSHIFT       => 304,
    SDLK_RCTRL        => 305,
    SDLK_LCTRL        => 306,
    SDLK_RALT         => 307,
    SDLK_LALT         => 308,
    SDLK_RMETA        => 309,
    SDLK_LMETA        => 310,
    SDLK_LSUPER       => 311,
    SDLK_RSUPER       => 312,
    SDLK_MODE         => 313,
    SDLK_COMPOSE      => 314,
    SDLK_HELP         => 315,
    SDLK_PRINT        => 316,
    SDLK_SYSREQ       => 317,
    SDLK_BREAK        => 318,
    SDLK_MENU         => 319,
    SDLK_POWER        => 320,
    SDLK_EURO         => 321,
    SDLK_UNDO         => 322,
); # SDL::Events/keysym

enum SDL::Constants::EventKeymod is export (
    KMOD_NONE     => 0x0000,
    KMOD_LSHIFT   => 0x0001,
    KMOD_RSHIFT   => 0x0002,
    KMOD_LCTRL    => 0x0040,
    KMOD_RCTRL    => 0x0080,
    KMOD_LALT     => 0x0100,
    KMOD_RALT     => 0x0200,
    KMOD_LMETA    => 0x0400,
    KMOD_RMETA    => 0x0800,
    KMOD_NUM      => 0x1000,
    KMOD_CAPS     => 0x2000,
    KMOD_MODE     => 0x4000,
    KMOD_RESERVED => 0x8000,
    KMOD_CTRL     => 0x0040 +| 0x0080,
    KMOD_SHIFT    => 0x0001 +| 0x0002,
    KMOD_ALT      => 0x0100 +| 0x0200,
    KMOD_META     => 0x0400 +| 0x0800,
); # SDL::Events/keymod

enum SDL::Constants::GFXSmoothing is export (
    SMOOTHING_OFF => 0,
    SMOOTHING_ON  => 1,
); # SDL::GFX/smoothing

enum SDL::Constants::ImageInit is export (
    IMG_INIT_JPG => 0x00000001,
    IMG_INIT_PNG => 0x00000002,
    IMG_INIT_TIF => 0x00000004,
); # SDL::Image

enum SDL::Constants::MixerInit is export (
    MIX_INIT_FLAC => 0x00000001,
    MIX_INIT_MOD  => 0x00000002,
    MIX_INIT_MP3  => 0x00000004,
    MIX_INIT_OGG  => 0x00000008,
); # SDL::Mixer/init

enum SDL::Constants::MixerDefaults is export (
    MIX_CHANNELS          => 8,
    MIX_DEFAULT_FORMAT    => 32784,
    MIX_DEFAULT_FREQUENCY => 22050,
    MIX_DEFAULT_CHANNELS  => 2,
    MIX_MAX_VOLUME        => 128,
    MIX_CHANNEL_POST      => -2,
); # SDL::Mixer/defaults

enum SDL::Constants::MixerFading is export (
    MIX_NO_FADING  => 0,
    MIX_FADING_OUT => 1,
    MIX_FADING_IN  => 2,
); # SDL::Mixer/fading

enum SDL::Constants::MixerType is export (
    MUS_NONE     => 0,
    MUS_CMD      => 1,
    MUS_WAV      => 2,
    MUS_MOD      => 3,
    MUS_MID      => 4,
    MUS_OGG      => 5,
    MUS_MP3      => 6,
    MUS_MP3_MAD  => 7,
    MUS_MP3_FLAC => 8,
); # SDL::Mixer/type

enum SDL::Constants::Net is export (
    INADDR_ANY              => 0x00000000,
    INADDR_NONE             => 0xFFFFFFFF,
    INADDR_BROADCAST        => 0xFFFFFFFF,
    SDLNET_MAX_UDPCHANNELS  => 32,
    SDLNET_MAX_UDPADDRESSES => 4,
); # SDL::Net

enum SDL::Constants::PangoDirection is export (
    SDLPANGO_DIRECTION_LTR      => 0,
    SDLPANGO_DIRECTION_RTL      => 1,
    SDLPANGO_DIRECTION_WEAK_LTR => 2,
    SDLPANGO_DIRECTION_WEAK_RTL => 3,
    SDLPANGO_DIRECTION_NEUTRAL  => 4,
); # SDL::Pango/direction

enum SDL::Constants::PangoAlign is export (
    SDLPANGO_ALIGN_LEFT   => 0,
    SDLPANGO_ALIGN_CENTER => 1,
    SDLPANGO_ALIGN_RIGHT  => 2,
); # SDL::Pango/align

enum SDL::Constants::RWOps is export (
    RW_SEEK_SET => 0,
    RW_SEEK_CUR => 1,
    RW_SEEK_END => 2,
); # SDL::RWOps/defaults

enum SDL::Constants::TTF is export (
    TTF_HINTING_NORMAL      => 0,
    TTF_HINTING_LIGHT       => 1,
    TTF_HINTING_MONO        => 2,
    TTF_HINTING_NONE        => 3,
    TTF_STYLE_NORMAL        => 0,
    TTF_STYLE_BOLD          => 1,
    TTF_STYLE_ITALIC        => 2,
    TTF_STYLE_UNDERLINE     => 4,
    TTF_STYLE_STRIKETHROUGH => 8,
); # SDL::TTF

enum SDL::Constants::Video is export (
    SDL_ALPHA_OPAQUE      => 255,
    SDL_ALPHA_TRANSPARENT => 0,

    SDL_SWSURFACE   => 0x00000000, # for SDL::Surface->new() and set_video_mode()
    SDL_HWSURFACE   => 0x00000001, # for SDL::Surface->new() and set_video_mode()
    SDL_ASYNCBLIT   => 0x00000004, # for SDL::Surface->new() and set_video_mode()
    SDL_ANYFORMAT   => 0x10000000, # set_video_mode()
    SDL_HWPALETTE   => 0x20000000, # set_video_mode()
    SDL_DOUBLEBUF   => 0x40000000, # set_video_mode()
    SDL_FULLSCREEN  => 0x80000000, # set_video_mode()
    SDL_OPENGL      => 0x00000002, # set_video_mode()
    SDL_OPENGLBLIT  => 0x0000000A, # set_video_mode()
    SDL_RESIZABLE   => 0x00000010, # set_video_mode()
    SDL_NOFRAME     => 0x00000020, # set_video_mode()
    SDL_HWACCEL     => 0x00000100, # set_video_mode()
    SDL_SRCCOLORKEY => 0x00001000, # set_video_mode()
    SDL_RLEACCELOK  => 0x00002000, # set_video_mode()
    SDL_RLEACCEL    => 0x00004000, # set_video_mode()
    SDL_SRCALPHA    => 0x00010000, # set_video_mode()
    SDL_PREALLOC    => 0x01000000, # set_video_mode()

    SDL_YV12_OVERLAY => 0x32315659, # Planar mode: Y + V + U  (3 planes)
    SDL_IYUV_OVERLAY => 0x56555949, # Planar mode: Y + U + V  (3 planes)
    SDL_YUY2_OVERLAY => 0x32595559, # Packed mode: Y0+U0+Y1+V0 (1 plane)
    SDL_UYVY_OVERLAY => 0x59565955, # Packed mode: U0+Y0+V0+Y1 (1 plane)
    SDL_YVYU_OVERLAY => 0x55595659, # Packed mode: Y0+V0+Y1+U0 (1 plane)

    SDL_LOGPAL  => 0x01,            # for set_palette()
    SDL_PHYSPAL => 0x02,            # for set_palette()

    SDL_GRAB_QUERY      => -1,      # SDL_GrabMode
    SDL_GRAB_OFF        => 0,       # SDL_GrabMode
    SDL_GRAB_ON         => 1,       # SDL_GrabMode
    SDL_GRAB_FULLSCREEN => 2,       # SDL_GrabMode, used internally
); # SDL::Video/...

enum SDL::Constants::VideoGL is export (
    SDL_GL_RED_SIZE           => 0,
    SDL_GL_GREEN_SIZE         => 1,
    SDL_GL_BLUE_SIZE          => 2,
    SDL_GL_ALPHA_SIZE         => 3,
    SDL_GL_BUFFER_SIZE        => 4,
    SDL_GL_DOUBLEBUFFER       => 5,
    SDL_GL_DEPTH_SIZE         => 6,
    SDL_GL_STENCIL_SIZE       => 7,
    SDL_GL_ACCUM_RED_SIZE     => 8,
    SDL_GL_ACCUM_GREEN_SIZE   => 9,
    SDL_GL_ACCUM_BLUE_SIZE    => 10,
    SDL_GL_ACCUM_ALPHA_SIZE   => 11,
    SDL_GL_STEREO             => 12,
    SDL_GL_MULTISAMPLEBUFFERS => 13,
    SDL_GL_MULTISAMPLESAMPLES => 14,
    SDL_GL_ACCELERATED_VISUAL => 15,
    SDL_GL_SWAP_CONTROL       => 16,
); # SDL::Video/gl
