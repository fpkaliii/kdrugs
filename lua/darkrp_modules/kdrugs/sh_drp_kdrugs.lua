DarkRP.createCategory({
	name = "kDrugs",
	categorises = "entities",
	startExpanded = true,
	color = Color(75, 120, 180)
})

DarkRP.createCategory({
	name = "kDrugs - Ingredients",
	categorises = "entities",
	startExpanded = true,
	color = Color(75, 125, 180)
})

function kdrugs.darkrp()
	include("kdrugs_config.lua")
	DarkRP.createEntity("Drug Lab", {
		ent = "kdrug_lab",
		model = "models/props_c17/FurnitureBoiler001a.mdl",
		cmd = "kdrugsbuylab",
		max = kdrugs.config.Lab.Maximum,
		price = kdrugs.config.Lab.Price,
		allowed = kdrugs.config.Lab.Allowed,
		category = "kDrugs"
	})

	for id, tab in next, kdrugs.ingredients do
		DarkRP.createEntity(tab[1], {
			ent = "kdrug_ing_" .. id,
			model = tab[3],
			cmd = "kdrugsbuy" .. id,
			max = kdrugs.config.Ingredients.Maximum,
			price = kdrugs.config.Ingredients.Price,
			allowed = kdrugs.config.Ingredients.Allowed,
			category = "kDrugs - Ingredients"
		})
	end
end

hook.Add("loadCustomDarkRPItems", "kdrugs.darkrp", kdrugs.darkrp)