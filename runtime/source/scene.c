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

// Aka BUFFER_SIZE + scene->name + \0 should cover execute_(name)
// and setup_(name)
static const int _SM_SCENE_FUNCTION_BUFFER_SIZE = 10;

static int _sm_scene_init_common(sm_scene *scene, sm_session *session, const char *name)
{
  assert(scene);
  assert(session);

  memset(scene, 0, sizeof(sm_scene));
  scene->session = session;

  scene->name = strdup(name);
  if (!scene->name) return SM_ERROR_MEMORY;

  scene->function_length = _SM_SCENE_FUNCTION_BUFFER_SIZE + strlen(name) + 1;
  scene->function = malloc(scene->function_length);
  if (!scene->function) return SM_ERROR_MEMORY;
  return SM_OK;
}

int sm_scene_init_from_file(sm_scene *scene, sm_session *session, const char *name,
    const char *filename)
{
  int res = _sm_scene_init_common(scene, session, name);
  if (res != SM_OK) return res;

  scene->filename = strdup(filename);
  if (!scene->filename) return SM_ERROR_MEMORY;

  res = luaL_dofile(scene->session->lua, scene->filename);
  if (res != LUA_OK)
  {
    scene->err = res;
    return SM_ERROR_LUA;
  }

  res = snprintf(scene->function, scene->function_length, "setup_%s", scene->name);
  assert(res <= scene->function_length - 1);
  lua_getglobal(scene->session->lua, scene->function);
  if (!lua_isfunction(scene->session->lua, -1))
    return SM_ERROR_LUA_RUNTIME;
  lua_pushlightuserdata(scene->session->lua, scene);
  lua_call(scene->session->lua, 1, 1);

  if (!lua_istable(scene->session->lua, -1))
    return SM_ERROR_LUA_RUNTIME;

  // TODO: Check table values (versions, etc)

  lua_pop(scene->session->lua, 1);

  res = snprintf(scene->function, scene->function_length, "execute_%s", scene->name);
  assert(res <= scene->function_length - 1);
  lua_getglobal(scene->session->lua, scene->function);
  if (!lua_isfunction(scene->session->lua, -1))
    return SM_ERROR_LUA_RUNTIME;
  lua_pop(scene->session->lua, 1);

  // TODO: Register 'name' in the sm_session

  return SM_OK;
}

int sm_scene_deinit(sm_scene *scene)
{
  if (!scene) return SM_OK;
  free(scene->function);
  free(scene->filename);
  free(scene->name);
  memset(scene, 0, sizeof(sm_scene));
  // TODO: Unregister 'name' in sm_session
  return SM_OK;
}

int sm_scene_execute(sm_scene *scene)
{
  assert(scene);
  assert(scene->session);

  return SM_OK;
}

