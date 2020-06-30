
include( "shared.lua" )

function ENT:Draw()
	self:DrawModel()
	local plyShootPos = LocalPlayer():GetShootPos()
	if self:GetPos():DistToSqr( plyShootPos ) < 562500 and !self:GetNWBool( "IsHidden" ) then
		surface.SetFont( "DermaLarge" )
		local title = "Tree"
		local title2 = "Current Health: "..self:Health()
		local ang = self:GetAngles()
		ang:RotateAroundAxis( self:GetAngles():Right(), 270 )
		ang:RotateAroundAxis( self:GetAngles():Forward(), 90 )
		local pos = self:GetPos() + ang:Right() * -45 + ang:Up() * 10 + ang:Forward() * -20
		cam.Start3D2D( pos, ang, 0.1 )
			draw.RoundedBox( 0, 50, -120, 250, 150, CRAFT_CONFIG_MENU_COLOR )
			draw.SimpleText( title, "DermaLarge", 175, -80, CRAFT_CONFIG_BUTTON_COLOR, 1, 1 )
			draw.SimpleText( title2, "DermaLarge", 175, -20, CRAFT_CONFIG_BUTTON_COLOR, 1, 1 )
		cam.End3D2D()
	end
end