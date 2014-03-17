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

static int _sm_scene_init_common(sm_scene *scene, sm_session *session, const char *name)
{
  assert(scene);
  assert(session);
  memset(scene, 0, sizeof(sm_scene));
  scene->session = session;
  scene->name = strdup(name);
  if (!scene->name) return SM_ERROR_MEMORY;
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

  // TODO: Check that execute_(scene->name) and setup_(scene->name)
  // exist, and call the setup function.  Setup should return a single
  // table of settings, which can be compared against expected values.
  //
  // TODO: Register 'name' in the sm_session

  return SM_OK;
}

int sm_scene_deinit(sm_scene *scene)
{
  if (!scene) return SM_OK;
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

