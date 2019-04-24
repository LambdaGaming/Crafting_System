
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
		local scrollbutton = vgui.Create( "DButton", mainframescroll )
		scrollbutton:SetText( tostring( v ) )
		scrollbutton:Dock( TOP )
		scrollbutton:DockMargin( 0, 0, 0, 5 )
	end
end

local function DrawRecipes( ent )
	local ply = LocalPlayer()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Choose an item to craft:" )
	mainframe:SetSize( 500, 700 )
	mainframe:Center()
	mainframe:MakePopup()
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for k,v in pairs( CraftingTable ) do
		local mainbuttons = vgui.Create( "DButton", mainframescroll )
		mainbuttons:SetText( v.Name )
		mainbuttons:Dock( TOP )
		mainbuttons:DockMargin( 0, 0, 0, 5 )
		mainbuttons.DoClick = function()
			ply:ChatPrint( "[Crafting Table]: "..v.Description )
			ply.SelectedCraftingItem = tostring( k )
		end
	end
	local craftbutton = vgui.Create( "DButton", mainframe )
	craftbutton:SetText( "Craft Selected Item" )
	craftbutton:SetPos( 25, 150 )
	craftbutton:SetSize( 250, 30 )
	craftbutton.DoClick = function()
		net.Start( "StartCrafting" )
		net.WriteEntity( ent )
		net.WriteString( ply.SelectedCraftingItem )
		net.SendToServer()
	end
end

local function DrawMainMenu( ent )
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Crafting Table - Main Menu" )
	mainframe:SetSize( 500, 700 )
	mainframe:Center()
	mainframe:MakePopup()
	local recipesbutton = vgui.Create( "DButton", mainframe )
	recipesbutton:SetText( "View Recipes/Craft an Item" )
	recipesbutton:SetPos( 25, 50 )
	recipesbutton:SetSize( 250, 30 )
	recipesbutton.DoClick = function()
		DrawRecipes( ent )
    end
	local itemsbutton = vgui.Create( "DButton", mainframe )
	itemsbutton:SetText( "View Items Currently on the Table" )
	itemsbutton:SetPos( 25, 100 )
	itemsbutton:SetSize( 250, 30 )
	itemsbutton.DoClick = function()
		DrawItems( ent )
	end
	local closebutton = vgui.Create( "DButton", mainframe )
	closebutton:SetText( "Exit Table" )
	closebutton:SetPos( 25, 150 )
	closebutton:SetSize( 150, 15 )
	closebutton.DoClick = function()
		mainframe:Close()
	end
end

net.Receive( "CraftingTableMenu", function( len, ply )
	local ent = net.ReadEntity()
	DrawMainMenu( ent )
end )
