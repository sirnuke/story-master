// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.c - Implements the Scene struct

#include <assert.h>
#include <string.h>
#include <stdlib.h>

#include <stdio.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include "scene.h"

static int _sm_callback_setup(lua_State *lua)
{
  assert(lua);
  printf("Setup callback from %p!\n", lua);
  return 0;
}

int sm_scene_init(sm_scene *s, sm_core *c, const char *name)
{
  assert(s);
  assert(c);
  memset(s, 0, sizeof(sm_scene));

  s->c = c;

  s->name = strdup(name);

  if (!s->name)
    return SM_ERROR_MEMORY;

  return SM_OK;
}

int sm_scene_deinit(sm_scene *s)
{
  assert(s);
  free(s->filename);
  free(s->name);
  if (s->lua)
  {
    int res = sm_scene_deload(s);
    if (res != SM_OK)
      return res;
  }
  memset(s, 0, sizeof(sm_scene));
  return SM_OK;
}

int sm_scene_load_from_file(sm_scene *s, const char *filename)
{
  assert(s);
  assert(s->c);

  s->filename = strdup(filename);

  s->lua = luaL_newstate();
  if (!s->lua)
    return SM_ERROR_MEMORY;
  luaL_openlibs(s->lua);

  int res = luaL_loadfile(s->lua, s->filename);

  if (res != LUA_OK)
  {
    s->err = res;
    return SM_ERROR_LUA;
  }

  lua_register(s->lua, "setup", _sm_callback_setup);

  res = lua_pcall(s->lua, 0, LUA_MULTRET, 0);

  if (res != LUA_OK)
  {
    s->err = res;
    return SM_ERROR_LUA;
  }
  return SM_OK;
}

int sm_scene_deload(sm_scene *s)
{
  assert(s);
  if (s->lua)
  {
    lua_close(s->lua);
    s->lua = NULL;
  }
  return SM_OK;
}

