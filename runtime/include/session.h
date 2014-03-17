// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// session.h - Defines the session struct and API calls

#ifndef ___SM_SESSION_H___
#define ___SM_SESSION_H___

#include "types.h"

struct lua_State;

struct sm_session
{
  struct sm_core *core;

  char *name;

  struct lua_State *lua;
};

int sm_session_init(sm_session *session, sm_core *core, const char *name);
int sm_session_deinit(sm_session *session);


#endif//___SM_SESSION_H___

