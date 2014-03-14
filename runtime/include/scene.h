// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.h - Defines the Scene class

#ifndef ___SM_SCENE_H___
#define ___SM_SCENE_H___

#include <stdbool.h>

//struct sm_core;
struct lua_State;

typedef struct
{
  struct sm_core *c;

  lua_State *lua;

  char *filename;
  char *name;

} sm_scene;

bool sm_scene_init(sm_scene *s, struct sm_core *c, const char *filename, const char *name);
bool sm_scene_deinit(sm_scene *s);

#endif//___SM_SCENE_H___

