
include('shared.lua')

function ENT:Draw()
    self:DrawModel()
end

local function DrawItems( ent )
	local mainframe = vgui.Create( "DFrame" )
    mainframe:SetTitle( "Items currently on the table:" )
    mainframe:SetSize( 500, 700 )
    mainframe:Center()
    mainframe:MakePopup()
    local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for k,v in ipairs( ent.CraftingItems ) do
		local scrollbutton = vgui.Create( "DButton" )
		scrollbutton:SetText( tostring( v ) )
		scrollbutton:Dock( TOP )
		scrollbutton:DockMargin( 0, 0, 0, 5 )
	end
end

local function DrawRecipes( ent )
	local mainframe = vgui.Create( "DFrame" )
    mainframe:SetTitle( "Choose an item to craft:" )
    mainframe:SetSize( 500, 700 )
    mainframe:Center()
    mainframe:MakePopup()
    local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	
end

local function DrawMainMenu( ent )
    local mainframe = vgui.Create( "DFrame" )
    mainframe:SetTitle( "Crafting Table - Main Menu" )
    mainframe:SetSize( 500, 700 )
    mainframe:Center()
    mainframe:MakePopup()
    local recipesbutton = vgui.Create( "DButton" )
    recipesbutton:SetText( "View Recipes/Craft an Item" )
    recipesbutton:SetPos( 25, 50 )
    recipesbutton:SetSize( 250, 30 )
    recipesbutton.DoClick = function()
		DrawRecipes( ent )

    end
end

net.Receive( "CraftingTableMenu", function( len, ply )
    local ent = net.ReadEntity()
    DrawMainMenu( ent )
end )
