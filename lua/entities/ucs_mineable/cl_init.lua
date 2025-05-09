include( "shared.lua" )

function ENT:Draw()
	self:DrawModel()
	local origin = self:GetPos()
	local ply = LocalPlayer()
	if ply:GetPos():DistToSqr( origin ) >= 589824 then return end

	local typ = self:GetMineableType()
	local data = self:GetData()
	local offset = data.TextOffset or vector_origin
	local name = data.Name or "Unnamed Mineable Entity"
	local health = self:Health()
	local maxHealth = self:GetMaxHealth()
	local pos = origin + offset
	local ang = ( ply:EyePos() - pos ):Angle()
	ang.p = 0
	ang:RotateAroundAxis( ang:Right(), 90 )
	ang:RotateAroundAxis( ang:Up(), 90 )
	ang:RotateAroundAxis( ang:Forward(), 180 )
	cam.Start3D2D( pos, ang, 0.035 )
		draw.SimpleText( name, "UCSOverheadText", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		draw.SimpleText( "Health: "..health.."/"..maxHealth, "UCSOverheadText", 0, 160, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	cam.End3D2D()
end
