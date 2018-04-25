unit module SDL::Functions;

use NativeCall;
use SDL::Structures;

# general
sub SDL_Init(int32)          returns int32       is native<SDL> is export { * }
sub SDL_InitSubSystem(int32) returns int32       is native<SDL> is export { * }
sub SDL_QuitSubSystem(int32)                     is native<SDL> is export { * }
sub SDL_WasInit(int32)       returns int32       is native<SDL> is export { * }
sub SDL_GetError()           returns Str         is native<SDL> is export { * }
sub SDL_Linked_Version()     returns SDL_version is native<SDL> is export { * }
sub SDL_RWFromFile(Str, Str) returns Pointer     is native<SDL> is export { * }
sub SDL_RWFromConstMem( Pointer, int32 ) returns Pointer is native<SDL> is export { * }

# Video
#| SDL_GetVideoSurface -- returns a pointer to the current display surface
#| SDL_GetVideoInfo -- returns a pointer to information about the video hardware
sub SDL_GetVideoInfo() returns SDL_VideoInfo  is native<SDL> { * }
#| SDL_VideoDriverName -- Obtain the name of the video driver
#| SDL_ListModes -- Returns a pointer to an array of available screen dimensions for the given format and video flags
#| SDL_VideoModeOK -- Check to see if a particular video mode is supported.
#| SDL_SetVideoMode -- Set up a video mode with the specified width, height and bits-per-pixel.
sub SDL_SetVideoMode(int32, int32, int32, int32) returns SDL_Surface is native<SDL> is export { * }
#| SDL_UpdateRect -- Makes sure the given area is updated on the given screen.
sub SDL_UpdateRect(SDL_Surface, int32, int32, int32, int32) is native<SDL> is export { * }
#| SDL_UpdateRects -- Makes sure the given list of rectangles is updated on the given screen.
#| SDL_Flip -- Swaps screen buffers
sub SDL_Flip(SDL_Surface) returns int32 is native<SDL> is export { * }
#| SDL_SetColors -- Sets a portion of the colormap for the given 8-bit surface.
#| SDL_SetPalette -- Sets the colors in the palette of an 8-bit surface.
#| SDL_SetGamma -- Sets the color gamma function for the display
#| SDL_GetGammaRamp -- Gets the color gamma lookup tables for the display
#| SDL_SetGammaRamp -- Sets the color gamma lookup tables for the display
#| SDL_MapRGB -- Map a RGB color value to a pixel format.
sub SDL_MapRGB(SDL_PixelFormat, uint8, uint8, uint8) returns uint32 is native<SDL> is export { * }
#| SDL_MapRGBA -- Map a RGBA color value to a pixel format.
#| SDL_GetRGB -- Get RGB values from a pixel in the specified pixel format.
#| SDL_GetRGBA -- Get RGBA values from a pixel in the specified pixel format.
#| SDL_CreateRGBSurface -- Create an empty SDL_Surface
sub SDL_CreateRGBSurface(uint32 $flags, int32 $width, int32 $height, int32 $depth, uint32 $Rmask, uint32 $Gmask, uint32 $Bmask, uint32 $Amask) returns SDL_Surface is native<SDL> is export { * }
#| SDL_CreateRGBSurfaceFrom -- Create an SDL_Surface from pixel data
#| SDL_FreeSurface -- Frees (deletes) a SDL_Surface
#| SDL_LockSurface -- Lock a surface for directly access.
#| SDL_UnlockSurface -- Unlocks a previously locked surface.
#| SDL_LoadBMP -- Load a Windows BMP file into an SDL_Surface.
#| SDL_SaveBMP -- Save an SDL_Surface as a Windows BMP file.
#| SDL_SetColorKey -- Sets the color key (transparent pixel) in a blittable surface and RLE acceleration.
#| SDL_SetAlpha -- Adjust the alpha properties of a surface
sub SDL_SetAlpha(SDL_Surface, uint32 $flag, uint8 $alpha) returns int32 is native<SDL> is export { * }
#| SDL_SetClipRect -- Sets the clipping rectangle for a surface.
#| SDL_GetClipRect -- Gets the clipping rectangle for a surface.
sub SDL_GetClipRect( Pointer, CArray[int32] )                                     is native<SDL> is export { * }
#| SDL_ConvertSurface -- Converts a surface to the same format as another surface.
sub SDL_ConvertSurface(SDL_Surface, SDL_PixelFormat, uint32 $flags) returns SDL_Surface is native<SDL> is export { * }
#| SDL_BlitSurface -- This performs a fast blit from the source surface to the destination surface.
sub SDL_BlitSurface(SDL_Surface, SDL_Rect, SDL_Surface, SDL_Rect) returns int32 is native<SDL> is export is symbol<SDL_UpperBlit> { * }
#| SDL_FillRect -- This function performs a fast fill of the given rectangle with some color
sub SDL_FillRect(SDL_Surface, SDL_Rect, int32)  returns int32 is native<SDL> is export { * }
#| SDL_DisplayFormat -- Convert a surface to the display format
#| SDL_DisplayFormatAlpha -- Convert a surface to the display format
#| SDL_WarpMouse -- Set the position of the mouse cursor.
#| SDL_CreateCursor -- Creates a new mouse cursor.
#| SDL_FreeCursor -- Frees a cursor created with SDL_CreateCursor.
#| SDL_SetCursor -- Set the currently active mouse cursor.
#| SDL_GetCursor -- Get the currently active mouse cursor.
#| SDL_ShowCursor -- Toggle whether or not the cursor is shown on the screen.
#| SDL_GL_LoadLibrary -- Specify an OpenGL library
#| SDL_GL_GetProcAddress -- Get the address of a GL function
#| SDL_GL_GetAttribute -- Get the value of a special SDL/OpenGL attribute
#| SDL_GL_SetAttribute -- Set a special SDL/OpenGL attribute
#| SDL_GL_SwapBuffers -- Swap OpenGL framebuffers/Update Display
#| SDL_CreateYUVOverlay -- Create a YUV video overlay
#| SDL_LockYUVOverlay -- Lock an overlay
#| SDL_UnlockYUVOverlay -- Unlock an overlay
#| SDL_DisplayYUVOverlay -- Blit the overlay to the display
#| SDL_FreeYUVOverlay -- Free a YUV video overlay

#| SDL_GLattr -- SDL GL Attributes
#| SDL_Rect -- Defines a rectangular area
#| SDL_Color -- Format independent color description
#| SDL_Palette -- Color palette for 8-bit pixel formats
#| SDL_PixelFormat -- Stores surface format information
#| SDL_Surface -- Graphical Surface Structure
#| SDL_VideoInfo -- Video Target information
#| SDL_Overlay -- YUV video overlay

# Window Management
#| SDL_WM_SetCaption -- Sets the window tile and icon name.
#| SDL_WM_GetCaption -- Gets the window title and icon name.
#| SDL_WM_SetIcon -- Sets the icon for the display window.
#| SDL_WM_IconifyWindow -- Iconify/Minimise the window
#| SDL_WM_ToggleFullScreen -- Toggles fullscreen mode
#| SDL_WM_GrabInput -- Grabs mouse and keyboard input.

# Events
#| SDL_PumpEvents -- Pumps the event loop, gathering events from the input devices.
sub SDL_PumpEvents() returns int32 is native<SDL> is export { * }
#| SDL_PeepEvents -- Checks the event queue for messages and optionally returns them.
#| SDL_PollEvent -- Polls for currently pending events.
sub SDL_PollEvent(SDL_Event is rw) returns int32 is native<SDL> is export { * }
#| SDL_WaitEvent -- Waits indefinitely for the next available event.
#| SDL_PushEvent -- Pushes an event onto the event queue
#| SDL_SetEventFilter -- Sets up a filter to process all events before they are posted to the event queue.
#| SDL_GetEventFilter -- Retrieves a pointer to he event filter
#| SDL_EventState -- This function allows you to set the state of processing certain events.
#| SDL_GetKeyState -- Get a snapshot of the current keyboard state
#| SDL_GetModState -- Get the state of modifier keys.
#| SDL_SetModState -- Set the current key modifier state
#| SDL_GetKeyName -- Get the name of an SDL virtual keysym
#| SDL_EnableUNICODE -- Enable UNICODE translation
#| SDL_EnableKeyRepeat -- Set keyboard repeat rate.
#| SDL_GetMouseState -- Retrieve the current state of the mouse
sub SDL_GetMouseState(int32 $x is rw, int32 $y is rw) returns uint8 is native<SDL> is export { * }

#| SDL_GetRelativeMouseState -- Retrieve the current state of the mouse
#| SDL_GetAppState -- Get the state of the application
#| SDL_JoystickEventState -- Enable/disable joystick event polling

# Joystick
#~ SDL_NumJoysticks -- Count available joysticks.
#~ SDL_JoystickName -- Get joystick name.
#~ SDL_JoystickOpen -- Opens a joystick for use.
#~ SDL_JoystickOpened -- Determine if a joystick has been opened
#~ SDL_JoystickIndex -- Get the index of an SDL_Joystick.
#~ SDL_JoystickNumAxes -- Get the number of joystick axes
#~ SDL_JoystickNumBalls -- Get the number of joystick trackballs
#~ SDL_JoystickNumHats -- Get the number of joystick hats
#~ SDL_JoystickNumButtons -- Get the number of joysitck buttons
#~ SDL_JoystickUpdate -- Updates the state of all joysticks
#~ SDL_JoystickGetAxis -- Get the current state of an axis
#~ SDL_JoystickGetHat -- Get the current state of a joystick hat
#~ SDL_JoystickGetButton -- Get the current state of a given button on a given joystick
#~ SDL_JoystickGetBall -- Get relative trackball motion
#~ SDL_JoystickClose -- Closes a previously opened joystick

# Audio
#~ SDL_AudioSpec -- Audio Specification Structure
#~ SDL_OpenAudio -- Opens the audio device with the desired parameters.
#~ SDL_PauseAudio -- Pauses and unpauses the audio callback processing
#~ SDL_GetAudioStatus -- Get the current audio state
#~ SDL_LoadWAV -- Load a WAVE file
#~ SDL_FreeWAV -- Frees previously opened WAV data
#~ SDL_AudioCVT -- Audio Conversion Structure
#~ SDL_BuildAudioCVT -- Initializes a SDL_AudioCVT structure for conversion
#~ SDL_ConvertAudio -- Convert audio data to a desired audio format.
#~ SDL_MixAudio -- Mix audio data
#~ SDL_LockAudio -- Lock out the callback function
#~ SDL_UnlockAudio -- Unlock the callback function
#~ SDL_CloseAudio -- Shuts down audio processing and closes the audio device.

# CDROM
#~ SDL_CDNumDrives -- Returns the number of CD-ROM drives on the system.
#~ SDL_CDName -- Returns a human-readable, system-dependent identifier for the CD-ROM.
#~ SDL_CDOpen -- Opens a CD-ROM drive for access.
#~ SDL_CDStatus -- Returns the current status of the given drive.
#~ SDL_CDPlay -- Play a CD
#~ SDL_CDPlayTracks -- Play the given CD track(s)
#~ SDL_CDPause -- Pauses a CDROM
#~ SDL_CDResume -- Resumes a CDROM
#~ SDL_CDStop -- Stops a CDROM
#~ SDL_CDEject -- Ejects a CDROM
#~ SDL_CDClose -- Closes a SDL_CD handle
#~ SDL_CD -- CDROM Drive Information
#~ SDL_CDtrack -- CD Track Information Structure

# Multi-threaded
#~ SDL_CreateThread -- Creates a new thread of execution that shares its parent's properties.
#~ SDL_ThreadID -- Get the 32-bit thread identifier for the current thread.
#~ SDL_GetThreadID -- Get the SDL thread ID of a SDL_Thread
#~ SDL_WaitThread -- Wait for a thread to finish.
#~ SDL_KillThread -- Gracelessly terminates the thread.
#~ SDL_CreateMutex -- Create a mutex
#~ SDL_DestroyMutex -- Destroy a mutex
#~ SDL_mutexP -- Lock a mutex
#~ SDL_mutexV -- Unlock a mutex
#~ SDL_CreateSemaphore -- Creates a new semaphore and assigns an initial value to it.
#~ SDL_DestroySemaphore -- Destroys a semaphore that was created by SDL_CreateSemaphore.
#~ SDL_SemWait -- Lock a semaphore and suspend the thread if the semaphore value is zero.
#~ SDL_SemTryWait -- Attempt to lock a semaphore but don't suspend the thread.
#~ SDL_SemWaitTimeout -- Lock a semaphore, but only wait up to a specified maximum time.
#~ SDL_SemPost -- Unlock a semaphore.
#~ SDL_SemValue -- Return the current value of a semaphore.
#~ SDL_CreateCond -- Create a condition variable
#~ SDL_DestroyCond -- Destroy a condition variable
#~ SDL_CondSignal -- Restart a thread wait on a condition variable
#~ SDL_CondBroadcast -- Restart all threads waiting on a condition variable
#~ SDL_CondWait -- Wait on a condition variable
#~ SDL_CondWaitTimeout -- Wait on a condition variable, with timeout

# Timer
#| SDL_GetTicks -- Get the number of milliseconds since the SDL library initialization.
sub SDL_GetTicks()           returns int32       is native<SDL> is export { * }
#| SDL_Delay -- Wait a specified number of milliseconds before returning.
sub SDL_Delay(int32)                             is native<SDL> is export { * }
#| SDL_AddTimer -- Add a timer which will call a callback after the specified number of milliseconds has elapsed.
#| SDL_RemoveTimer -- Remove a timer which was added with SDL_AddTimer.
#| SDL_SetTimer -- Set a callback to run after the specified number of milliseconds has elapsed.

# Image
sub IMG_Init(int32)             returns int32       is native<SDL_image> is export { * }
sub IMG_Load(Str)               returns SDL_Surface is native<SDL_image> is export { * }
sub IMG_Load_RW(Pointer, int32) returns SDL_Surface is native<SDL_image> is export { * }
sub IMG_isBMP(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isCUR(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isICO(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isGIF(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isJPG(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isLBM(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isPCX(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isPNG(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isPNM(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isTIF(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isXCF(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isXPM(Pointer)          returns int32       is native<SDL_image> is export { * }
sub IMG_isXV(Pointer)           returns int32       is native<SDL_image> is export { * }

# Mixer General
sub Mix_Linked_Version()                                 returns SDL_version is native<SDL_mixer> is export { * }
#~ 4.1.2 Mix_Init	  	Initialize SDL_mixer
#~ 4.1.3 Mix_Quit	  	Cleanup SDL_mixer
sub Mix_OpenAudio(int32, int32, int32, int32)            returns int32     is native<SDL_mixer> is export { * }
sub Mix_CloseAudio()                                     returns int32     is native<SDL_mixer> is export { * }
#~ 4.1.6 Mix_SetError	  	Set the current error string
#~ 4.1.7 Mix_GetError	  	Get the current error string
#~ 4.1.8 Mix_QuerySpec	  	Get output format

# Mixer Samples
#~ 4.2.1 Mix_GetNumChunkDecoders	  	Number of sample format types that can be decoded
#~ 4.2.2 Mix_GetChunkDecoder	  	Name of enumerated sample format type decoder
sub Mix_LoadWAV_RW(Pointer, int32)                       returns Mix_Chunk is native<SDL_mixer> is export { * }
sub Mix_LoadWAV(Str $file)                               returns Mix_Chunk is export {
    Mix_LoadWAV_RW(SDL_RWFromFile($file, "rb"), 1);
}
#~ 4.2.5 Mix_QuickLoad_WAV	  	From memory, in output format already
#~ 4.2.6 Mix_QuickLoad_RAW	  	From memory, in output format already
#~ 4.2.7 Mix_VolumeChunk	  	Set mix volume
#~ 4.2.8 Mix_FreeChunk	  	Free sample

# Mixer Channels
sub Mix_AllocateChannels(int32)                          returns int32     is native<SDL_mixer> is export { * }
sub Mix_Volume(int32, int32)                             returns int32     is native<SDL_mixer> is export { * }
#~ 4.3.3 Mix_PlayChannel	  	Play loop
sub Mix_PlayChannelTimed(int32, Mix_Chunk, int32, int32) returns int32     is native<SDL_mixer> is export { * }
sub Mix_FadeInChannelTimed(int32, Mix_Chunk, int32, int32, int32) returns int32 is native<SDL_mixer> is export { * }
sub Mix_FadeInChannel(int32 $channel, Mix_Chunk $chunk, int32 $loops, int32 $ms) returns int32 is export {
    Mix_FadeInChannelTimed($channel, $chunk, $loops, $ms, -1);
}
sub Mix_Pause(int32)                                                       is native<SDL_mixer> is export { * }
sub Mix_Resume(int32)                                                      is native<SDL_mixer> is export { * }
sub Mix_HaltChannel(int32)                               returns int32     is native<SDL_mixer> is export { * }
sub Mix_ExpireChannel(int32, int32)                      returns int32     is native<SDL_mixer> is export { * }
sub Mix_FadeOutChannel(int32, int32)                     returns int32     is native<SDL_mixer> is export { * }
sub Mix_ChannelFinished(&callback (int32))               returns int32     is native<SDL_mixer> is export { * }
sub Mix_Playing(int32)                                   returns int32     is native<SDL_mixer> is export { * }
sub Mix_Paused(int32)                                    returns int32     is native<SDL_mixer> is export { * }
sub Mix_FadingChannel(int32)                             returns int32     is native<SDL_mixer> is export { * }
sub Mix_GetChunk(int32)                                  returns Mix_Chunk is native<SDL_mixer> is export { * }

# Mixer Groups
#~ 4.4.1 Mix_ReserveChannels	  	Prevent channels from being used in default group
#~ 4.4.2 Mix_GroupChannel	  	Add/remove channel to/from group
#~ 4.4.3 Mix_GroupChannels	  	Add/remove segment of channels to/from group
#~ 4.4.4 Mix_GroupCount	  	Get number of channels in group
#~ 4.4.5 Mix_GroupAvailable	  	Get first inactive channel in group
#~ 4.4.6 Mix_GroupOldest	  	Get oldest busy channel in group
#~ 4.4.7 Mix_GroupNewer	  	Get youngest busy channel in group
#~ 4.4.8 Mix_FadeOutGroup	  	Fade out a group over time
#~ 4.4.9 Mix_HaltGroup	  	Stop a group

# Mixer Music
#~ 4.5.1 Mix_GetNumMusicDecoders	  	Number of music format types that can be decoded
#~ 4.5.2 Mix_GetMusicDecoder	  	Name of enumerated music format type decoder
#~ 4.5.3 Mix_LoadMUS	  	Load a music file into a Mix_Music
#~ 4.5.4 Mix_FreeMusic	  	Free a Mix_Music
#~ 4.5.5 Mix_PlayMusic	  	Play music, with looping
#~ 4.5.6 Mix_FadeInMusic	  	Play music, with looping, and fade in
#~ 4.5.7 Mix_FadeInMusicPos	  	Play music from a start point, with looping, and fade in
#~ 4.5.8 Mix_HookMusic	  	Hook for a custom music player
#~ 4.5.9 Mix_VolumeMusic	  	Set music volume
#~ 4.5.10 Mix_PauseMusic	  	Pause music
#~ 4.5.11 Mix_ResumeMusic	  	Resume paused music
#~ 4.5.12 Mix_RewindMusic	  	Rewind music to beginning
#~ 4.5.13 Mix_SetMusicPosition	  	Set position of playback in stream
#~ 4.5.14 Mix_SetMusicCMD	  	Use external program for music playback
#~ 4.5.15 Mix_HaltMusic	  	Stop music playback
#~ 4.5.16 Mix_FadeOutMusic	  	Stop music, with fade out
#~ 4.5.17 Mix_HookMusicFinished	  	Set a callback for when music stops
#~ 4.5.18 Mix_GetMusicType	  	Get the music encoding type
#~ 4.5.19 Mix_PlayingMusic	  	Test whether music is playing
#~ 4.5.20 Mix_PausedMusic	  	Test whether music is paused
#~ 4.5.21 Mix_FadingMusic	  	Get status of current music fade activity
#~ 4.5.22 Mix_GetMusicHookData	  	Retrieve the Mix_HookMusic arg

# Mixer Effects
#~ 4.6.1 Mix_RegisterEffect	  	Hook a processor to a channel
#~ 4.6.2 Mix_UnregisterEffect	  	Unhook a processor from a channel
#~ 4.6.3 Mix_UnregisterAllEffects	  	Unhook all processors from a channel
#~ 4.6.4 Mix_SetPostMix	  	Hook in a postmix processor
#~ 4.6.5 Mix_SetPanning	  	Stereo panning
#~ 4.6.6 Mix_SetDistance	  	Distance attenuation (volume)
#~ 4.6.7 Mix_SetPosition	  	Panning(angular) and distance
#~ 4.6.8 Mix_SetReverseStereo	  	Swap stereo left and right
