drug.id = "coke"
drug.name = "Cocaine"
drug.ingredients = {
	{"Coca Leaves", "coca", "models/props_junk/garbage_plasticbottle003a.mdl", 5},
	{"Kerosene", "kerosene", "models/props_junk/metalgascan.mdl", 2},
	{"Sulfuric Acid", "sulfacid", "models/props_junk/metalgascan.mdl", 2},
	{"Caustic Soda", "soda", "models/props_junk/metalgascan.mdl", 3},
}

drug.time = 25
drug.atime = 3.75
function drug:DrawEffects(num, after, start)
	DrawSharpen(num * 0.4, num * 0.4)
	DrawMotionBlur(num * 0.025, num * 0.05, 0.01)
end

function drug:Start(ply, num)
	if num >= 6 then
		ply:Kill()
		return
	end

	ply:SetHealth(ply:Health() + 5)
	ply:SetWalkSpeed(ply:GetWalkSpeed() + 30)
	ply:SetRunSpeed(ply:GetRunSpeed() + 40)
end

function drug:End(ply, num)
	ply:SetHealth(ply:Health() - (num * 6))
	ply:SetWalkSpeed(ply:GetWalkSpeed() - (num * 40))
	ply:SetRunSpeed(ply:GetRunSpeed() - (num * 50))
end

function drug:EndAfterEffects(ply, num)
	ply:SetHealth(ply:Health() + (num * 10))
	ply:SetWalkSpeed(ply:GetWalkSpeed() + (num * 12))
	ply:SetRunSpeed(ply:GetRunSpeed() + (num * 12))
end