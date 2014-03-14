// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.h - Defines the Scene class

#ifndef ___SM_SCENE_H___
#define ___SM_SCENE_H___

#include <string>

namespace sm
{

class Core;
struct lua_State;

class Scene
{
public:
  Scene(Core *core);
  ~Scene();

  bool load(const std::string &filename, const std::string &name);

  bool isInit() { return init; }

private:
  bool init;
  Core *core;
  std::string filename;
  std::string name;

  lua_State *lua;

};

} // namespace

#endif//___SM_SCENE_H___

