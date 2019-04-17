include('shared.lua')

function ENT:Draw()
    self:DrawModel()
end

local function DrawItems( ent )
    local leftframe = vgui.Create( "DFrame" )
    leftframe:SetTitle( "Current items on the table:" )
    leftframe:SetSize( 500, 700 )
    leftframe:AlignLeft()
    leftframe:MakePopup()
    leftframe:ShowCloseButton( false )
    local leftframescroll = vgui.Create( "DScrollPanel", leftframe )
    leftframescroll:Dock( FILL )
    for k,v in pairs( ent.CraftingItems ) do
        
    end

    local rightframe = vgui.Create( "DFrame" )
    rightframe:SetTitle( "Choose an item to craft:" )
    rightframe:SetSize( 500, 700 )
    rightframe:AlignRight()
    rightframe:MakePopup()
    rightframe:ShowCloseButton( false )
    local rightframescroll = vgui.Create( "DScrollPanel", rightframe )
    rightframescroll:Dock( FILL )
    for k,v in pairs( ent.CraftingTable ) do
        
    end
    
    local centerframe = vgui.Create( "DFrame" )
    centerframe:SetSize( 300, 50 )
    centerframe:Center()
    centerframe:MakePopup()
    centerframe:SetBackgroundColor( Color( 255, 255, 255, 0 ) )
    centerframe:ShowCloseButton( false )
    local craftbutton = vgui.Create(  )
end

net.Receive( "CraftingTableMenu", function( len, ply )
    local ent = net.ReadEntity()
    DrawItems( ent )
end )
