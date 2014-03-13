// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.h - Defines the Scene class

#ifndef ___SM_SCENE_H___
#define ___SM_SCENE_H___

namespace sm
{

class Core;

class Scene
{
public:
  Scene(Core *core);
  ~Scene();

private:
  Core *core;

};

} // namespace

#endif//___SM_SCENE_H___

