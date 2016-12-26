kdrugs.config = {
	-- darkrp config --
	Lab = {
		Maximum = 5, // max amount of drug labs a single player can buy
		Price = 1500, // price of each drug lab
		Allowed = { // jobs that can buy the drug lab
			TEAM_GANG,
			TEAM_MOB
		}
	},

	Ingredients = {
		Maximum = 15, // max amount of each ingredient a player can buy
		Price = 50, // price of each ingredient
		Allowed = { // jobs that can buy the ingredients
			TEAM_GANG
		}
	}
}