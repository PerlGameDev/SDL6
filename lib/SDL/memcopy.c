#include <string.h>

#ifdef WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

DLLEXPORT void *GetBuf( const void *from, void *to, size_t len )
{
	return memcpy( to, from, len );
}

DLLEXPORT void *GetPointer( size_t len )
{
	return (void *)len;
}


