// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.c - Implements scene API calls

#include <assert.h>
#include <string.h>
#include <stdlib.h>

#include <stdio.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include "scene.h"
#include "session.h"

/*
static int _sm_callback_setup(lua_State *lua)
{
  assert(lua);
  printf("Setup callback from %p!\n", lua);
  return 0;
}
*/

int sm_scene_init(sm_scene *scene, sm_session *session, const char *name)
{
  assert(scene);
  assert(session);
  memset(scene, 0, sizeof(sm_scene));

  scene->session = session;

  scene->name = strdup(name);
  if (!scene->name) return SM_ERROR_MEMORY;

  return SM_OK;
}

int sm_scene_deinit(sm_scene *scene)
{
  if (!scene) return SM_OK;
  free(scene->filename);
  free(scene->name);
  memset(scene, 0, sizeof(sm_scene));
  return SM_OK;
}

int sm_scene_load_from_file(sm_scene *scene, const char *filename)
{
  assert(scene);
  assert(scene->session);

  scene->filename = strdup(filename);
  if (!scene->filename) return SM_ERROR_MEMORY;

  int res = luaL_dofile(scene->session->lua, scene->filename);
  if (res != LUA_OK)
  {
    scene->err = res;
    return SM_ERROR_LUA;
  }

  return SM_OK;
}

int sm_scene_execute(sm_scene *scene)
{
  assert(scene);
  assert(scene->session);

  return SM_OK;
}

