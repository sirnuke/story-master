// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// directives.h - Implements basic Lua directive callbacks

#ifndef ___SM_DIRECTIVES_H___
#define ___SM_DIRECTIVES_H___

#include "types.h"

struct lua_State;

int _sm_directives_register(struct lua_State *lua);

#endif//___SM_DIRECTIVES_H___
