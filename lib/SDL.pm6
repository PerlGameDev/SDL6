
module SDL;

use NativeCall;

constant SDL_INIT_VIDEO = 32;

class SDL::Version is repr('CStruct') {  # typedef struct {
    has uint8 $.major;                   #     Uint8 major;
    has uint8 $.minor;                   #     Uint8 minor;
    has uint8 $.patch;                   #     Uint8 patch;
}                                        # } SDL_version;

=begin pod

=head2 init

 SDL::init( $flags );

The SDL::init function initializes the Simple Directmedia Library and the subsystems specified by C<$flags>. It should be called before all other SDL functions.

B<Note>: Unless the C<$SDL_INIT_NOPARACHUTE> flag is set, it will install cleanup signal handlers for some commonly ignored fatal signals (like SIGSEGV). 

B<Parameter>:

$flags - The SDL subsystem(s) to initialize. The flags can be bitwise-ORed together. You should specify the subsystems which you will be using in your application.

 $SDL_INIT_AUDIO        The audio subsystem
 $SDL_INIT_VIDEO        The video subsystem
 $SDL_INIT_CDROM        The cdrom subsystem
 $SDL_INIT_JOYSTICK     The joystick subsystem
 $SDL_INIT_TIMER        The timer subsystem
 $SDL_INIT_EVERYTHING   All of the above
 $SDL_INIT_NOPARACHUTE  Prevents SDL from catching fatal signals
 $SDL_INIT_EVENTTHREAD  Runs the event manager in a separate thread 

B<Return value>:

C<SDL::init> returns C<0> on success, or C<-1> on error.

B<Example>:

 if 0 != SDL::init( $SDL_INIT_AUDIO +| $SDL_INIT_VIDEO ) {
     die 'Failed to initialize libSDL with reason: "' ~ SDL::get_error() ~ '"';
 }

B<Note>: You can get extended error message by calling C<SDL::get_error()>. Typical cause of this error is using a particular display without having according subsystem support,
such as missing mouse driver when using with framebuffer device. In this case you can either compile SDL without mouse device, or set C<"SDL_NOMOUSE=1"> environment variable before running your application. 

=end pod

our sub init( int32 )             returns Int            is native('libSDL')  is symbol('SDL_Init')            { * }
our sub init_subsystem( int32 )   returns Int            is native('libSDL')  is symbol('SDL_InitSubSystem')   { * }
our sub quit_subsystem( int32 )                          is native('libSDL')  is symbol('SDL_QuitSubSystem')   { * }
our sub was_init( int32 )         returns Int            is native('libSDL')  is symbol('SDL_WasInit')         { * }
our sub get_ticks( )              returns Int            is native('libSDL')  is symbol('SDL_GetTicks')        { * }
our sub get_error( )              returns Str            is native('libSDL')  is symbol('SDL_GetError')        { * }
our sub delay( int32 )                                   is native('libSDL')  is symbol('SDL_Delay')           { * }
our sub linked_version( )         returns SDL::Version   is native('libSDL')  is symbol('SDL_Linked_Version')  { * }
our sub rw_from_file( Str, Str )  returns OpaquePointer  is native('libSDL')  is symbol('SDL_RWFromFile')      { * }

=begin DATA
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_AddTimer')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_AllocRW')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_AudioDriverName')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_AudioInit')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_AudioQuit')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_BuildAudioCVT')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDClose')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDEject')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDName')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDNumDrives')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDOpen')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDPause')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDPlay')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDPlayTracks')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDResume')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDStatus')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CDStop')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ClearError')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CloseAudio')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CondBroadcast')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CondSignal')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CondWait')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CondWaitTimeout')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ConvertAudio')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ConvertSurface')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CreateCond')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CreateCursor')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CreateMutex')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CreateRGBSurface')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CreateRGBSurfaceFrom')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CreateSemaphore')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CreateThread')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_CreateYUVOverlay')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_DestroyCond')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_DestroyMutex')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_DestroySemaphore')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_DisplayFormat')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_DisplayFormatAlpha')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_DisplayYUVOverlay')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_EnableKeyRepeat')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_EnableUNICODE')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_Error')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_EventState')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_FillRect')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_Flip')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_FreeCursor')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_FreeRW')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_FreeSurface')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_FreeWAV')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_FreeYUVOverlay')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GL_GetAttribute')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GL_GetProcAddress')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GL_LoadLibrary')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GL_Lock')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GL_SetAttribute')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GL_SwapBuffers')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GL_Unlock')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GL_UpdateRects')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetAppState')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetAudioStatus')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetClipRect')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetCursor')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetEventFilter')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetGammaRamp')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetKeyName')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetKeyRepeat')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetKeyState')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetModState')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetMouseState')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetRGB')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetRGBA')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetRelativeMouseState')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetThreadID')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetTicks')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetVideoInfo')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetVideoSurface')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_GetWMInfo')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_Has3DNow')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_Has3DNowExt')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_HasAltiVec')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_HasMMX')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_HasMMXExt')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_HasRDTSC')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_HasSSE')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_HasSSE2')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickClose')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickEventState')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickGetAxis')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickGetBall')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickGetButton')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickGetHat')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickIndex')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickName')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickNumAxes')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickNumBalls')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickNumButtons')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickNumHats')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickOpen')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickOpened')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_JoystickUpdate')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_KillThread')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ListModes')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_LoadBMP_RW')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_LoadFunction')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_LoadObject')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_LoadWAV_RW')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_LockAudio')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_LockSurface')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_LockYUVOverlay')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_LowerBlit')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_MapRGB')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_MapRGBA')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_MixAudio')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_NumJoysticks')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_OpenAudio')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_PauseAudio')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_PeepEvents')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_PushEvent')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_Quit')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_RWFromFP')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_RWFromFile')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_RWFromMem')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ReadBE16')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ReadBE32')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ReadBE64')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ReadLE16')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ReadLE32')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ReadLE64')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_RemoveTimer')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SaveBMP_RW')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SemPost')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SemTryWait')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SemValue')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SemWait')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SemWaitTimeout')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetAlpha')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetClipRect')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetColorKey')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetColors')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetCursor')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetError')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetEventFilter')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetGamma')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetGammaRamp')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetModState')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetPalette')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetTimer')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SetVideoMode')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ShowCursor')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_SoftStretch')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ThreadID')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_UnloadObject')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_UnlockAudio')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_UnlockSurface')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_UnlockYUVOverlay')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_UpdateRect')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_UpdateRects')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_UpperBlit')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_VideoDriverName')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_VideoInit')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_VideoModeOK')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_VideoQuit')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WM_GetCaption')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WM_GrabInput')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WM_IconifyWindow')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WM_SetCaption')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WM_SetIcon')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WM_ToggleFullScreen')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WaitEvent')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WaitThread')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WarpMouse')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WriteBE16')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WriteBE32')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WriteBE64')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WriteLE16')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WriteLE32')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_WriteLE64')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_iconv')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_iconv_string')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_lltoa')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ltoa')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_mutexP')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_mutexV')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_revcpy')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_strlcat')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_strlcpy')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_strlwr')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_strrev')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_strupr')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ulltoa')	{ * }
our sub init( int32 )		returns Int	is native('libSDL')	is named('SDL_ultoa')	{ * }
=end DATA
