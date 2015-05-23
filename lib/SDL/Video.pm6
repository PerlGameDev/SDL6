unit module SDL::Video;

use NativeCall;

class SDL::VideoInfo is repr('CStruct') {
	has int $.a;
	has int $.b;
	has int $.c;
	method current_w() {
		return $.c +& 0xFFFF;
	}
	method current_h() {
		return ($.c +> 32) +& 0xFFFF;
	}
}

our sub get_video_info( )  returns SDL::VideoInfo  is native('libSDL')  is symbol('SDL_GetVideoInfo')  { * }
