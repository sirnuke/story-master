// StoryMaster Simulator
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// simulator.cpp - Main file for the sample StoryMaster simulator.

#include <cstdlib>
#include <cstdio>

#include <iostream>

#include <storymaster.h>

int main(int argc, const char *argv[])
{
  sm_core *core = (sm_core *)(malloc(sizeof(sm_core)));
  sm_scene *scene = (sm_scene *)(malloc(sizeof(sm_scene)));

  sm_core_init(core);
  sm_scene_init(scene, core, "examples/dialog.scene.lua", "dialog");

  // ...

  sm_scene_deinit(scene);
  sm_core_deinit(core);

  free(scene);
  free(core);

  return 0;
}

