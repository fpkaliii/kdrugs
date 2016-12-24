AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	if self.ingredient then
		self:SetModel(self.ingredient[3])
	end

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetPos(self:GetPos() + Vector(0, 0, 5))
end

function ENT:Touch(ent)
	if ent:GetClass() == "kdrug_lab" and self.ingredient and !self.touched then
		self.touched = true
		ent:AddIngredient(self.ingredient[1])
		self:Remove()
	end
end