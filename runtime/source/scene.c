// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.cpp - Implements the Scene class

#include <cassert>

extern "C"
{
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
}

#include "scene.h"

sm::Scene::Scene(Core *core) : init(false), core(core), lua(NULL)
{
  assert(core);
}

sm::Scene::~Scene()
{
}

bool sm::Scene::load(const std::string &filename, const std::string &name)
{
  this->name = name;
  this->filename = filename;
  init = true;
  return true;
}

