// example file
drug.id = "hmo"
drug.name = "Hydromethorphan"
drug.ingredients = {
	{"Dextromethorphan", "dxm", "models/props_lab/jar01b.mdl", 3},
	{"Hydrochloric Acid", "hcacid", "models/props_junk/garbage_plasticbottle001a.mdl", 1},
	{"Alcohol", "alcohol", "models/props_junk/garbage_plasticbottle003a.mdl", 2},
	{"Iodine", "iodine", "models/props_junk/metalgascan.mdl", 1}
}

drug.time = 45
drug.atime = 7.5
function drug:DrawEffects(num, after, start)
	local me = LocalPlayer()
	local curtime = CurTime()
	num = num + 1
	if after then
		num = num * ((start + self.time + self.atime - curtime) / self.atime)
	end

	local angles = Angle(0, 0, 0)
	if num >= 2 then
		angles = Angle(0, math.sin(curtime * 2.15) * num * 0.25, 0)
	end

	local fov_desired = GetConVar("fov_desired"):GetInt()
	render.RenderView({
		angles = me:EyeAngles() + angles,
		fov = fov_desired + 16.25 + (math.sin(curtime * 1.75) * num * 0.75),
		viewmodelfov = 70 + (math.cos(curtime * 1.25) * num * 0.45),
	})

	if num >= 3 then
		surface.SetDrawColor(Color(255, 255, 255, math.abs(math.sin(curtime * 1.35) * math.Clamp(num * 2, 1, 90))))
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end
end

function drug:Start(ply, num)
	ply:SetHealth(ply:Health() + 50)
	ply:SetWalkSpeed(ply:GetWalkSpeed() + 350)
	ply:SetRunSpeed(ply:GetRunSpeed() + 275)
	ply:SetWalkSpeed(math.Clamp(ply:GetWalkSpeed(), 1, 800))
	ply:SetRunSpeed(math.Clamp(ply:GetRunSpeed(), 1, 600))
end

function drug:End(ply, num)
	ply:SetHealth(ply:Health() - (num * 55))
	if 0 >= ply:Health() then
		ply:Kill()
		return
	end

	ply:SetWalkSpeed(ply:GetWalkSpeed() - (num * 375))
	ply:SetRunSpeed(ply:GetRunSpeed() - (num * 300))
	ply:SetWalkSpeed(math.Clamp(ply:GetWalkSpeed(), 100, 400))
	ply:SetRunSpeed(math.Clamp(ply:GetRunSpeed(), 50, 200))
end

function drug:EndAfterEffects(ply, num)
	ply:SetHealth(ply:Health() + (num * 10))
	ply:SetWalkSpeed(200)
	ply:SetRunSpeed(400)
end