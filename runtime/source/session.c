// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// session.c - Implements session API calls

#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include "directives.h"
#include "session.h"

int sm_session_init(sm_session *session, sm_core *core, const char *name)
{
  assert(session);
  assert(core);

  memset(session, 0, sizeof(sm_session));

  session->core = core;
  session->name = strdup(name);

  if (!session->name) return SM_ERROR_MEMORY;

  session->lua = luaL_newstate();
  if (!session->lua) return SM_ERROR_MEMORY;
  luaL_openlibs(session->lua);

  lua_register(session->lua, "dialog", &_sm_directive_dialog);

  return SM_OK;
}

int sm_session_deinit(sm_session *session)
{
  if (!session) return SM_OK;
  free(session->name);
  if (session->lua) lua_close(session->lua);
  memset(session, 0, sizeof(sm_session));
  return SM_OK;
}


