AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetPos(self:GetPos() + Vector(0, 0, 5))
end

function ENT:Use(_, ply)
	if !ply:IsValid() or !ply:IsPlayer() then return end
	ply.kdrugs = ply.kdrugs or {}
	if self.drug then
		local extra = 0
		if ply.kdrugs[self.drug.id] then
			extra = ply.kdrugs[self.drug.id].extra + 1
		end

		ply.kdrugs[self.drug.id] = {time = CurTime(), extra = extra, started = false}
		net.Start("kdrugs")
		net.WriteString(self.drug.id)
		net.WriteString(tostring(ply.kdrugs[self.drug.id].time))
		net.WriteString(tostring(ply.kdrugs[self.drug.id].extra))
		net.Send(ply)
	end

	self:Remove()
end