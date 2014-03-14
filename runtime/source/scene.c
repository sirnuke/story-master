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

bool sm_scene_init(sm_scene *s, sm_core *c, const char *filename, const char *name)
{
  assert(s);
  assert(c);
  memset(s, 0, sizeof(sm_scene));

  s->filename = strdup(filename);
  s->name = strdup(filename);

  assert(s->filename);
  assert(s->name);

  s->lua = luaL_newstate();
  assert(s->lua);
  luaL_openlibs(s->lua);

  return true;
}

bool sm_scene_deinit(sm_scene *s)
{
  assert(s);
  free(s->filename);
  free(s->name);
  lua_close(s->lua);
  memset(s, 0, sizeof(sm_scene));
  return true;
}

