// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// core.h - Defines the core struct and API calls

#ifndef ___SM_CORE_H___
#define ___SM_CORE_H___

#include <stdbool.h>

#include "types.h"

struct sm_core
{
  sm_callback_dialog dialog;
};

int sm_core_init(sm_core *core);
int sm_core_deinit(sm_core *core);

#endif//___SM_CORE_H___

