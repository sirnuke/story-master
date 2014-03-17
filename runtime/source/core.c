// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// core.c - Implements the core API calls

#include <assert.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

#include "core.h"

int sm_core_init(sm_core *core)
{
  assert(core);
  memset(core, 0, sizeof(sm_core));
  return SM_OK;
}

int sm_core_deinit(sm_core *core)
{
  assert(core);
  memset(core, 0, sizeof(sm_core));
  return SM_OK;
}

