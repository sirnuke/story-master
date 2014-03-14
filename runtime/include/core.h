// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// core.h - Class wrapping around an initialized instance of the runtime

#ifndef ___SM_CORE_H___
#define ___SM_CORE_H___

#include <stdbool.h>

#include "types.h"

struct sm_core
{
};

bool sm_core_init(sm_core *c);
bool sm_core_deinit(sm_core *c);

#endif//___SM_CORE_H___

