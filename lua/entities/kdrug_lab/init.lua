AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel("models/props_c17/FurnitureBoiler001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.ingredients = {}
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetPos(self:GetPos() + Vector(0, 0, 35))
end

function ENT:UpdateOnClient()
	net.Start("kdrugs.lab")
	net.WriteEntity(self)
	net.WriteTable(self.ingredients)
	net.Broadcast()
end

function ENT:AddIngredient(name)
	self.ingredients[name] = self.ingredients[name] and self.ingredients[name] + 1 or 1
	self:UpdateOnClient()
end

function ENT:Use(_, ply)
	if !self.nextuse then
		self.nextuse = CurTime() + 0.5
	elseif self.nextuse > CurTime() then
		return
	end
	
	for id, drug in next, kdrugs.drugs do
		local has = 0
		local remove = {}
		for index, tab in next, drug.ingredients do
			if self.ingredients[tab[1]] and self.ingredients[tab[1]] >= tab[4] then
				remove[tab[1]] = tab[4]
				has = has + 1
			end
		end

		if has == table.Count(drug.ingredients) then
			local meme = ents.Create("kdrug_" .. id)
			if !meme:IsValid() then return end
			for name, count in next, remove do
				self.ingredients[name] = self.ingredients[name] - count
				if 0 >= self.ingredients[name] then
					self.ingredients[name] = nil
				end
			end

			self:UpdateOnClient()
			local min, max = self:GetCollisionBounds()
			meme:SetPos(self:GetPos() + Vector(0, 0, max.z + 15))
			meme:Spawn()
		end
	end
end