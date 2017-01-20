drug.id = "meth"
drug.name = "Methamphetamine"
drug.ingredients = {
	{"Psuedoephedrine Tablets", "psuedophed", "models/props_lab/jar01b.mdl", 3},
	{"Naptha", "naptha", "models/props_junk/garbage_plasticbottle001a.mdl", 2},
	{"Red Phosphorus", "redphos", "models/props_junk/garbage_plasticbottle003a.mdl", 2},
	{"Hydriodic Acid", "hydroacid", "models/props_junk/metalgascan.mdl", 2},
	{"Lye", "lye", "models/props_junk/metalgascan.mdl", 2}
}

drug.time = 30
drug.atime = 7.5
function drug:DrawEffects(num, after, start)
	DrawSharpen(math.Clamp(num, 1, 8) * 0.2, math.Clamp(num, 1, 8) * 0.2)
	DrawMotionBlur(num * 0.05, num * 0.1, 0.025)
end

function drug:Start(ply, num)
	if num >= 10 then
		ply:Kill()
		return
	end

	ply:SetHealth(ply:Health() + 10)
	ply:SetWalkSpeed(ply:GetWalkSpeed() + 20)
	ply:SetRunSpeed(ply:GetRunSpeed() + 25)
end

function drug:End(ply, num)
	ply:SetHealth(ply:Health() - (num * 12))
	ply:SetWalkSpeed(ply:GetWalkSpeed() - (num * 30))
	ply:SetRunSpeed(ply:GetRunSpeed() - (num * 40))
end

function drug:EndAfterEffects(ply, num)
	ply:SetHealth(ply:Health() + (num * 5))
	ply:SetWalkSpeed(ply:GetWalkSpeed() + (num * 20))
	ply:SetRunSpeed(ply:GetRunSpeed() + (num * 25))
end