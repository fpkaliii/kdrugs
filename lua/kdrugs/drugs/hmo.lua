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
	num = math.Clamp(num, 1, 12)
	local me = LocalPlayer()
	local curtime = CurTime()
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

	if num >= 8 then
		surface.SetDrawColor(Color(255, 255, 255, math.abs(math.sin(curtime * 1.35) * math.Clamp(num * 2, 1, 90))))
		surface.DrawRect(0, 0, ScrW(), ScrH())
	end
end