// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// directives.cpp - Implements basic Lua directive callbacks

#include <assert.h>

#include <stdio.h>

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include "directives.h"

static int _sm_directive_dialog(lua_State *lua)
{
  assert(lua);
  int args = lua_gettop(lua);
  // TODO: Less hardcoding plz
  // TODO: Likely be a forth parameter with settings
  assert(args == 3);
  assert(lua_islightuserdata(lua, 1));
  assert(lua_isstring(lua, 2));
  assert(lua_isstring(lua, 3));

  printf("Dialog: %s: %s\n", lua_tostring(lua, 2), lua_tostring(lua, 3));

  lua_pop(lua, args);
  return 0;
}

int _sm_directives_register(struct lua_State *lua)
{
  assert(lua);

  lua_register(lua, "dialog", &_sm_directive_dialog);

  return SM_OK;
}

