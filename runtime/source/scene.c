// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.c - Implements the Scene struct

#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include "scene.h"

bool sm_scene_init(sm_scene *s, struct sm_core *c, const char *filename, const char *name)
{
  assert(s);
  assert(c);

  return true;
}

bool sm_scene_deinit(sm_scene *s)
{
  assert(s);
  free(s->filename);
  free(s->name);
  memset(s, 0, sizeof(sm_scene));
  return true;
}



