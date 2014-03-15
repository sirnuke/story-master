// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.h - Defines the Scene class

#ifndef ___SM_SCENE_H___
#define ___SM_SCENE_H___

#include "types.h"

struct lua_State;

struct sm_scene
{
  struct sm_core *c;

  struct lua_State *lua;

  char *name;
  char *filename;
};

bool sm_scene_init(sm_scene *s, sm_core *c, const char *name);
bool sm_scene_deinit(sm_scene *s);
bool sm_scene_load_from_file(sm_scene *s, const char *filename);

#endif//___SM_SCENE_H___

