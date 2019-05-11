
include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

local DrawItems, DrawRecipes, DrawMainMenu

DrawItems = function( ent )
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Items currently on the table:" )
	mainframe:SetSize( 500, 700 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_MENU_COLOR )
	end
	local backbutton = vgui.Create( "DButton", mainframe )
	backbutton:SetText( "Back" )
	backbutton:SetPos( 0, 0 )
	backbutton:SetSize( 50, 10 )
	backbutton.DoClick = function()
		mainframe:Close()
		DrawMainMenu( ent )
	end

	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for k,v in pairs( CraftingTable ) do
		for a,b in pairs( v.Materials ) do
			local scrollbutton = vgui.Create( "DButton", mainframescroll )
			if ent:GetNWInt( "Craft_"..a ) == nil then
				scrollbutton:SetText( a..": 0" )
			else
				scrollbutton:SetText( a..": "..ent:GetNWInt( "Craft_"..a ) )
			end
			scrollbutton:Dock( TOP )
			scrollbutton:DockMargin( 0, 0, 0, 5 )
		end
	end
end

DrawRecipes = function( ent )
	local ply = LocalPlayer()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Choose an item to craft:" )
	mainframe:SetSize( 500, 700 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_MENU_COLOR )
	end
	local backbutton = vgui.Create( "DButton", mainframe )
	backbutton:SetText( "Back" )
	backbutton:SetPos( 0, 0 )
	backbutton:SetSize( 50, 10 )
	backbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	backbutton.DoClick = function()
		mainframe:Close()
		DrawMainMenu( ent )
	end
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for k,v in pairs( CraftingTable ) do
		local mainbuttons = vgui.Create( "DButton", mainframescroll )
		mainbuttons:SetText( v.Name )
		mainbuttons:Dock( TOP )
		mainbuttons:DockMargin( 0, 0, 0, 5 )
		mainbuttons.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
		end
		mainbuttons.DoClick = function()
			chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 100, 255, 100 ), "<"..v.Name.."> ", Color( 255, 255, 255 ), v.Description )
			ply.SelectedCraftingItem = tostring( k )
			ply.SelectedCraftingItemName = v.Name
		end
	end
	local craftbutton = vgui.Create( "DButton", mainframe )
	craftbutton:SetText( "Craft Selected Item" )
	craftbutton:SetPos( 25, 150 )
	craftbutton:SetSize( 250, 30 )
	craftbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	craftbutton.DoClick = function()
		if !ply.SelectedCraftingItem then
			chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 255, 255, 255 ), "Please select an item to craft." )
			return
		end
		net.Start( "StartCrafting" )
		net.WriteEntity( ent )
		net.WriteString( ply.SelectedCraftingItem )
		net.WriteString( ply.SelectedCraftingItemName )
		net.SendToServer()
		mainframe:Close()
		ply.SelectedCraftingItem = nil
		ply.SelectedCraftingItemName = nil
	end
end

DrawMainMenu = function( ent )
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Crafting Table - Main Menu" )
	mainframe:SetSize( 500, 700 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_MENU_COLOR )
	end
	local recipesbutton = vgui.Create( "DButton", mainframe )
	recipesbutton:SetText( "View Recipes/Craft an Item" )
	recipesbutton:SetPos( 25, 50 )
	recipesbutton:SetSize( 250, 30 )
	recipesbutton:CenterHorizontal()
	recipesbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	recipesbutton.DoClick = function()
		DrawRecipes( ent )
		mainframe:Close()
    end
	local itemsbutton = vgui.Create( "DButton", mainframe )
	itemsbutton:SetText( "View Items Currently on the Table" )
	itemsbutton:SetPos( 25, 100 )
	itemsbutton:SetSize( 250, 30 )
	itemsbutton:CenterHorizontal()
	itemsbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	itemsbutton.DoClick = function()
		DrawItems( ent )
		mainframe:Close()
	end
	local closebutton = vgui.Create( "DButton", mainframe )
	closebutton:SetText( "Exit Table" )
	closebutton:SetPos( 25, 150 )
	closebutton:SetSize( 150, 15 )
	closebutton:CenterHorizontal()
	closebutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	closebutton.DoClick = function()
		mainframe:Close()
	end
end

net.Receive( "CraftingTableMenu", function( len, ply ) --Receiving the net message to open the main crafting table menu
	local ent = net.ReadEntity()
	DrawMainMenu( ent )
end )

net.Receive( "CraftMessage", function( len, ply ) --Have to network the entname into here since the client can't see it serverside
	local validfunction = net.ReadBool()
	local entname = net.ReadString()
	if validfunction then
		chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 255, 255, 255 ), "Successfully crafted a "..entname.." ." )
	else
		chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 255, 255, 255 ), "ERROR! Missing SpawnFunction for "..entname.." ("..ent..")" )
	end
end )