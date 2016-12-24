function kdrugs.load()
	local files = file.Find("kdrugs/drugs/*.lua", "LUA")
	for i,v in ipairs(files) do
		if SERVER then AddCSLuaFile("kdrugs/drugs/" .. v) end
		drug = {}
		include("kdrugs/drugs/" .. v)
		kdrugs.drugs[drug.id] = drug
		local ent = {}
		ent.Type = "anim"
		ent.Base = "kdrug"
		ent.PrintName = drug.name
		ent.Category = "kdrugs"
		ent.Spawnable = true
		ent.AdminSpawnable = true
		ent.drug = drug
		scripted_ents.Register(ent, "kdrug_" .. drug.id)
		for index, tab in next, drug.ingredients do
			if !kdrugs.ingredients[tab[2]] then
				ent = {}
				ent.Type = "anim"
				ent.Base = "kdrug_ing"
				ent.PrintName = tab[1]
				ent.Category = "kdrugs - ing"
				ent.Spawnable = true
				ent.AdminSpawnable = true
				ent.ingredient = tab
				kdrugs.ingredients[tab[2]] = tab
				scripted_ents.Register(ent, "kdrug_ing_" .. tab[2])
			end
		end
	end
end