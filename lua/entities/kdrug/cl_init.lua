include("shared.lua")
function ENT:Draw()
	self:DrawModel()
	local min, max = self:GetCollisionBounds()
	local angles = self:GetAngles()
	local text = "meme"
	if self.drug then
		text = self.drug.name
	end

	cam.Start3D2D(self:GetPos() + Vector(0, 0, max.z + 5 + math.sin(CurTime() * 1.5)), Angle(0, math.NormalizeAngle(CurTime() * 60), 90), 0.5)
		draw.SimpleText(text, "Default", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()

	cam.Start3D2D(self:GetPos() + Vector(0, 0, max.z + 5 + math.sin(CurTime() * 1.5)), Angle(0, math.NormalizeAngle(CurTime() * 60) + 180, 90), 0.5)
		draw.SimpleText(text, "Default", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end