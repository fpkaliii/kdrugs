if SERVER then
	AddCSLuaFile()
	include("kdrugs/sv_kdrugs.lua")
else
	include("kdrugs/cl_kdrugs.lua")
end