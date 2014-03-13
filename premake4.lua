-- StoryMaster Runtime
-- Bryan DeGrendel (c) 2014
--
-- See LICENSE for licensing information.
--
-- premake4.lua - Premake configuration for the storymaster runtime

solution "StoryMaster"
  configurations { "SharedDebug", "SharedRelease", "StaticDebug", "StaticRelease" }
  language "C++"

  project "StoryMasterRuntime"
    targetname "storymaster"

    files { "runtime/source/*.cpp", "runtime/include/*.h" }
    includedirs { "runtime/include" }
    links { "lua5.2" }

    flags { "ExtraWarnings" }

    configuration "Shared*"
      kind "SharedLib"

    configuration "Static*"
      kind "StaticLib"

    configuration "*Debug"
      defines { "_DEBUG" }
      flags { "Symbols" }

    configuration "*Release"
      defines { "NDEBUG" }
      flags { "Optimize" }

