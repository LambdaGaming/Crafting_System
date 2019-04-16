include('shared.lua')

function ENT:Draw()
    self:DrawModel()
end

local function DrawItems()
    cam.Start3D2D( self:GetPos() + Vector( 0, 0, 100 ), Angle( 0, 0, 0 ), 1 )
        surface.DrawRect(number x, number y, number width, number height)
end
hook.Add( "HUDPaint", "DrawItems", DrawItems() )