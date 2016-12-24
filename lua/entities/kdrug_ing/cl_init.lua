include("shared.lua")
function ENT:Draw()
	self:DrawModel()
	local min, max = self:GetCollisionBounds()
	local angles = self:GetAngles()
	local text = "meme"
	local usedin = {}
	if self.ingredient then
		text = self.ingredient[1]
		if kdrugs then
			for id, drug in next, kdrugs.drugs do
				for _id, ing in next, drug.ingredients do
					if ing[1] == self.ingredient[1] then
						usedin[#usedin + 1] = drug.name
					end
				end
			end
		end

		if #usedin >= 1 then
			usedin[#usedin + 1] = "Used in:"
		end
	end

	local function DrawTextCrap()
		draw.SimpleText(text, "Default", 0, #usedin * -12 - 12, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		for i = 1, #usedin do
			local name = usedin[i]
			draw.SimpleText(name, "Default", 0, (i - 1) * -12, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	
	cam.Start3D2D(self:GetPos() + Vector(0, 0, max.z + 5 + math.sin(CurTime() * 1.5)), Angle(0, math.NormalizeAngle(CurTime() * 60), 90), 0.5)
		DrawTextCrap()
	cam.End3D2D()

	cam.Start3D2D(self:GetPos() + Vector(0, 0, max.z + 5 + math.sin(CurTime() * 1.5)), Angle(0, math.NormalizeAngle(CurTime() * 60) + 180, 90), 0.5)
		DrawTextCrap()
	cam.End3D2D()
end