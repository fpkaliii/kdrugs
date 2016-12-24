include("shared.lua")
function ENT:Draw()
	self:DrawModel()
	local min, max = self:GetCollisionBounds()
	local angles = self:GetAngles()
	local text = "Drug Lab"
	local contents = {}
	if self.ingredients then
		for name, count in next, self.ingredients do
			contents[#contents + 1] = name .. " x" .. tostring(count)
		end

		if #contents >= 1 then
			contents[#contents + 1] = "Contents: "
		end
	end

	local function DrawTextCrap()
		draw.SimpleText(text, "Default", 0, #contents * -12 - 12, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		for i = 1, #contents do
			local name = contents[i]
			draw.SimpleText(name, "Default", 0, (i - 1) * -12, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	
	cam.Start3D2D(self:GetPos() + Vector(0, 0, max.z + 5 + math.sin(CurTime() * 3)), Angle(0, math.NormalizeAngle(CurTime() * 100), 90), 0.5)
		DrawTextCrap()
	cam.End3D2D()

	cam.Start3D2D(self:GetPos() + Vector(0, 0, max.z + 5 + math.sin(CurTime() * 3)), Angle(0, math.NormalizeAngle(CurTime() * 100) + 180, 90), 0.5)
		DrawTextCrap()
	cam.End3D2D()
end