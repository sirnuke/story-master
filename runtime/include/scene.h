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

  int err;
};

int sm_scene_init(sm_scene *s, sm_core *c, const char *name);
int sm_scene_deinit(sm_scene *s);

int sm_scene_load_from_file(sm_scene *s, const char *filename);
int sm_scene_deload(sm_scene *s);

#endif//___SM_SCENE_H___

