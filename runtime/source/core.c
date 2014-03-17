// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// core.c - Class wrapping around an initialized instance of the runtime

#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

#include "core.h"

int sm_core_init(sm_core *c)
{
  assert(c);
  memset(c, 0, sizeof(sm_core));
  return SM_OK;
}

int sm_core_deinit(sm_core *c)
{
  assert(c);
  memset(c, 0, sizeof(sm_core));
  return SM_OK;
}

