
unit class SDL::PixelFormat is repr('CStruct');

use SDL::Palette;

has SDL::Palette $.palette;
#~ has uint8  $.BitsPerPixel;
#~ has uint8  $.BytesPerPixel;
#~ has uint8  $.Rloss;
#~ has uint8  $.Gloss;
#~ has uint8  $.Bloss;
#~ has uint8  $.Aloss;
#~ has uint8  $.Rshift;
#~ has uint8  $.Gshift;
#~ has uint8  $.Bshift;
#~ has uint8  $.Ashift;has uint8  $.BitsPerPixel;
has int8  $.BytesPerPixel;
has int8  $.Rloss;
has int8  $.Gloss;
has int8  $.Bloss;
has int8  $.Aloss;
has int8  $.Rshift;
has int8  $.Gshift;
has int8  $.Bshift;
has int8  $.Ashift;
#~ has uint32 $.Rmask;
#~ has uint32 $.Gmask;
#~ has uint32 $.Bmask;
#~ has uint32 $.Amask;
#~ has uint32 $.colorkey;
has int32 $.Rmask;
has int32 $.Gmask;
has int32 $.Bmask;
has int32 $.Amask;
has int32 $.colorkey;
#~ has uint8  $.alpha;
has int8  $.alpha;
