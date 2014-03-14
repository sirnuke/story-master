// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// types.h - Define various types used in the runtime

#ifndef ___SM_TYPES_H___
#define ___SM_TYPES_H___

#include <stdbool.h>

#define SM_VERSION_MAJOR 0
#define SM_VERSION_MINOR 0
#define SM_VERSION_PATCH 1
#define SM_VERSION_STRING #SM_VERSION_MAJOR "." #SM_VERSION_MINOR "." #SM_VERSION_PATCH

typedef struct sm_core sm_core;
typedef struct sm_scene sm_scene;

#endif//___SM_TYPES_H___

