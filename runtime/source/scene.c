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

bool sm_scene_init(sm_scene *s, sm_core *c, const char *name)
{
  assert(s);
  assert(c);
  memset(s, 0, sizeof(sm_scene));

  s->c = c;

  s->name = strdup(name);

  assert(s->name);

  return true;
}

bool sm_scene_deinit(sm_scene *s)
{
  assert(s);
  free(s->filename);
  free(s->name);
  if (s->lua) lua_close(s->lua);
  memset(s, 0, sizeof(sm_scene));
  return true;
}

bool sm_scene_load_from_file(sm_scene *s, const char *filename)
{
  assert(s);
  assert(s->c);

  s->filename = strdup(filename);

  s->lua = luaL_newstate();
  assert(s->lua);
  luaL_openlibs(s->lua);

  int res = luaL_loadfile(s->lua, s->filename);

  switch (res)
  {
  case LUA_ERRSYNTAX: 
  case LUA_ERRMEM:
  case LUA_ERRGCMM:
    errno = res;
    return false;
  case LUA_OK:
    return true;
  default:
    assert(false);
  }
}

