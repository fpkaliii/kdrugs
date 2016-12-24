kdrugs = {}
include("kdrugs_config.lua")
include("sh_kdrugs.lua")
function kdrugs.take()
	local drug = net.ReadString()
	local time = net.ReadString()
	local extra = net.ReadString()
	kdrugs.taken[drug] = {time = tonumber(time), extra = tonumber(extra)}
end

function kdrugs.draw()
	local me = LocalPlayer()
	if !me:IsValid() then return end
	local curtime = CurTime()
	for id,tab in next, kdrugs.taken do
		local drug = kdrugs.drugs[id]
		if tab.time + drug.time + drug.atime >= curtime and me:Alive() then
			drug:DrawEffects(tab.extra, curtime > tab.time + drug.time, tab.time)
		elseif !me:Alive() or tab.time + drug.time + drug.atime >= curtime then
			kdrugs.taken[id] = nil
		end
	end
end

function kdrugs.lab()
	local ent = net.ReadEntity()
	local tab = net.ReadTable()
	if ent and ent:IsValid() then
		ent.ingredients = tab
	end
end

kdrugs.load()
net.Receive("kdrugs", kdrugs.take)
net.Receive("kdrugs.lab", kdrugs.lab)
hook.Add("HUDPaint", "kdrugs.draw", kdrugs.draw)