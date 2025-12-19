-- premake5.lua

require('vstudio')

premake.override(premake.vstudio.vc2010.elements, "globals", function(base, cfg)
   base(cfg)
   premake.w("<VcpkgEnabled>false</VcpkgEnabled>")
end)

workspace "WalnutApp"
   architecture "x64"
   configurations { "Debug", "Release", "Dist" }
   startproject "WalnutApp"

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

include "WalnutExternal.lua"
include "WalnutApp"