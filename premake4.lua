-- StoryMaster Runtime
-- Bryan DeGrendel (c) 2014
--
-- See LICENSE for licensing information.
--
-- premake4.lua - Premake configuration for the storymaster runtime

solution "StoryMaster"
  configurations { "Debug", "Release" }

  project "Simulator"
    language "C++"
    targetname "sim"
    kind "ConsoleApp"

    files { "simulator/source/*.cpp", "runtime/include/*.h" }
    includedirs { "simulator/include", "runtime/include" }
    links { "lua5.2", "Runtime" }

    flags { "ExtraWarnings" }

    configuration "Debug"
      defines { "_DEBUG" }
      flags { "Symbols" }

    configuration "Release"
      defines { "NDEBUG" }
      flags { "Optimize" }

  project "Runtime"
    language "C"
    targetname "storymaster"
    kind "StaticLib"

    files { "runtime/source/*.c", "runtime/include/*.h" }
    includedirs { "runtime/include", "/usr/include/lua5.2" }
    links { "lua5.2" }

    flags { "ExtraWarnings" }

    configuration "Debug"
      defines { "_DEBUG" }
      flags { "Symbols" }

    configuration "Release"
      defines { "NDEBUG" }
      flags { "Optimize" }

