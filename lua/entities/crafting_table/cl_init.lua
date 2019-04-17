include('shared.lua')

function ENT:Draw()
    self:DrawModel()
end

local function DrawItems( ent )
    local leftframe = vgui.Create( "DFrame" )
    leftframe:SetTitle( "Current items on the table:" )
    leftframe:SetSize( 500, 700 )
    leftframe:Center()
    leftframe:MakePopup()
    local leftframescroll = vgui.Create( "DScrollPanel", leftframe )
    leftframescroll:Dock( FILL )
    for i=1, #ent.CraftingItems() do
        
    end

    local rightframe = vgui.Create( "DFrame" )
    rightframe:SetTitle( "Choose and item to craft:" )
    rightframe:SetSize( 500, 700 )
    rightframe:
end

net.Receive( "CraftingTableMenu", function( len, ply )
    local ent = net.ReadEntity()
    DrawItems( ent )
end )