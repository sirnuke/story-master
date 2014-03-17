// StoryMaster Runtime
// Bryan DeGrendel (c) 2014
//
// See LICENSE for licensing information.
//
// scene.h - Defines the scene struct and API calls

#ifndef ___SM_SCENE_H___
#define ___SM_SCENE_H___

#include "types.h"

struct sm_scene
{
  struct sm_session *session;

  char *name;
  char *filename;

  int err;
};

int sm_scene_init(sm_scene *scene, sm_session *session, const char *name);
int sm_scene_deinit(sm_scene *scene);

int sm_scene_load_from_file(sm_scene *scene, const char *filename);
int sm_scene_execute(sm_scene *scene);

#endif//___SM_SCENE_H___

