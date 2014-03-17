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

using namespace std;

int main(int argc, const char *argv[])
{
  cout << "Operating over [examples/dialog.scene.lua] with runtime " SM_VERSION_STRING << endl;

  sm_core *core = (sm_core *)(malloc(sizeof(sm_core)));
  sm_session *session = (sm_session *)(malloc(sizeof(sm_session)));
  sm_scene *scene = (sm_scene *)(malloc(sizeof(sm_scene)));

  // TODO: Check return valuez and all that
  sm_core_init(core);
  sm_session_init(session, core, "common");
  sm_scene_init_from_file(scene, session, "dialog", "example/dialog.lua");

  sm_scene_execute(scene);

  sm_scene_deinit(scene);
  sm_session_deinit(session);
  sm_core_deinit(core);

  free(scene);
  free(session);
  free(core);

  return 0;
}

