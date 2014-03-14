// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// core.h - Class wrapping around an initialized instance of the runtime

#ifndef ___SM_CORE_H___
#define ___SM_CORE_H___

namespace sm
{

class Core
{
public:
  Core();
  ~Core();

  bool initialize();

  bool isInit() { return init; }

private:
  bool init;
};

}

#endif//___SM_CORE_H___

