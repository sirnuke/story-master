// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// types.h - Define various types used in the runtime

#ifndef ___SM_TYPES_H___
#define ___SM_TYPES_H___

#define _SM_STRINGIFY(X) #X
#define _SM_STR(X) _SM_STRINGIFY(X)

#define SM_VERSION_MAJOR 0
#define SM_VERSION_MINOR 0
#define SM_VERSION_PATCH 1
#define SM_VERSION_STRING _SM_STR(SM_VERSION_MAJOR) "." _SM_STR(SM_VERSION_MINOR) "." _SM_STR(SM_VERSION_PATCH)

#define SM_OK 0
#define SM_ERROR_MEMORY 1
#define SM_ERROR_LUA 2

typedef struct sm_core sm_core;
typedef struct sm_scene sm_scene;
typedef struct sm_session sm_session;

#endif//___SM_TYPES_H___

