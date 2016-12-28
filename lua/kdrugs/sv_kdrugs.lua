util.AddNetworkString("kdrugs")
util.AddNetworkString("kdrugs.lab")
AddCSLuaFile("cl_kdrugs.lua")
AddCSLuaFile("sh_kdrugs.lua")
AddCSLuaFile("kdrugs_config.lua")
kdrugs = {}
include("kdrugs_config.lua")
include("sh_kdrugs.lua")
function kdrugs.think()
	local curtime = CurTime()
	for k,v in next, player.GetAll() do
		if !v.kdrugs then continue end
		for id, tab in next, v.kdrugs do
			local drug = kdrugs.drugs[id]
			if tab.time + drug.time + drug.atime >= curtime and v:Alive() then
				if drug.Start and !tab.started and tab.time + drug.time >= curtime then
					drug:Start(v, tab.extra)
					tab.started = true
				elseif drug.End and tab.started and curtime >= tab.time + drug.time then
					drug:End(v, tab.extra)
					tab.started = false
				end
			else
				v.kdrugs[id] = nil
				if drug.EndAfterEffects then
					drug:EndAfterEffects(v, tab.extra)
				end
			end
		end
	end
end

function kdrugs.startcommand(ply, cmd)
	local curtime = CurTime()
	if ply.kdrugs then
		for id, tab in next, ply.kdrugs do
			local drug = kdrugs.drugs[id]
			if drug.AlterMovement and tab.time + drug.time + drug.atime >= curtime and ply:Alive() then
				drug:AlterMovement(cmd, tab.extra)
			end
		end
	end
end

kdrugs.load()
hook.Add("Think", "kdrugs.think", kdrugs.think)
hook.Add("StartCommand", "kdrugs.startcommand", kdrugs.startcommand)