// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// core.cpp - Class wrapping around an initialized instance of the runtime

#include "core.h"

sm::Core::Core() : init(false)
{
}

sm::Core::~Core()
{
}

bool sm::Core::initialize()
{
  init = true;
  return true;
}

