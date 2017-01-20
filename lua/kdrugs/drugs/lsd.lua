drug.id = "lsd"
drug.name = "LSD"
drug.ingredients = {
	{"Lysergic Acid", "lysacid", "models/props_lab/jar01b.mdl", 1},
	{"Phosphorus Oxychloride", "oxychloride", "models/props_junk/garbage_plasticbottle001a.mdl", 1},
	{"Phosphorus Pentachloride", "penchloride", "models/props_junk/garbage_plasticbottle001a.mdl", 1},
	{"Diethylamine", "diethamine", "models/props_junk/garbage_plasticbottle001a.mdl", 1}
}

drug.time = 60
drug.atime = 1
function drug:DrawEffects(num, after, start)
	DrawSharpen(1.25 + (num * 0.75), 1.25 + (num * 0.75))
	DrawMotionBlur(num * 0.01, num * 0.0125, 0.005)
end

function drug:AlterMovement(ply, num)
	local max = math.Clamp(num, 1, 5) * 0.05
	ply:SetEyeAngles(ply:EyeAngles() + Angle(math.Rand(-max, max), math.Rand(-max * 2, max * 2), 0))
end