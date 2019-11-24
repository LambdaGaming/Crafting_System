
include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

local DrawItems, DrawRecipes, DrawMainMenu --Initialize these early so the client can see them when using the back buttons

DrawItems = function( ent ) --Panel that draws the list of materials that are on the table
	local itemtable = {}
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Items currently on the table:" )
	mainframe:SetSize( 500, 500 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_MENU_COLOR )
	end
	local backbutton = vgui.Create( "DButton", mainframe )
	backbutton:SetText( "Back" )
	backbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	backbutton:SetPos( 350, 3 )
	backbutton:SetSize( 50, 20 )
	backbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	backbutton.DoClick = function()
		mainframe:Close()
		DrawMainMenu( ent )
		surface.PlaySound( GetConVar( "Craft_Config_UI_Sound" ):GetString() )
	end

	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for k,v in pairs( CraftingIngredient ) do --Looks over the keys inside the materials table, luckily Lua is fine converting them to strings
		if table.HasValue( itemtable, k ) then 
			continue --Prevents two or more of the same materials from being listed if they are used in more than one recipe
		end
		local scrollbutton = vgui.Create( "DButton", mainframescroll )
		if ent:GetNWInt( "Craft_"..v.Name ) == nil then --If networked int doesn't exist then just set it's value to 0 until it does
			scrollbutton:SetText( v.Name..": 0" )
		else
			scrollbutton:SetText( v.Name..": "..ent:GetNWInt( "Craft_"..v.Name ) )
		end
		scrollbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
		scrollbutton:Dock( TOP )
		scrollbutton:DockMargin( 0, 0, 0, 5 )
		scrollbutton.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
		end
		scrollbutton.DoClick = function()
			if ent:GetNWInt( "Craft_"..v.Name ) == nil or ent:GetNWInt( "Craft_"..v.Name ) == 0 then
				surface.PlaySound( GetConVar( "Craft_Config_Fail_Sound" ):GetString() )
				return --Prevents players from having negative ingredients
			end
			net.Start( "DropItem" )
			net.WriteEntity( ent )
			net.WriteString( k )
			net.SendToServer() --Sends the net message to drop the specified item and remove it from the table
			timer.Simple( 0.3, function() --Small timer to let the net message go through
				mainframe:Close()
				DrawItems( ent ) --Refreshes the panel so it updates the number of materials
			end )
		end
		table.insert( itemtable, k )
	end
end

DrawRecipes = function( ent ) --Panel that draws the list of recipes
	local ply = LocalPlayer()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Choose an item to craft:" )
	mainframe:SetSize( 500, 500 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_MENU_COLOR )
	end
	local backbutton = vgui.Create( "DButton", mainframe )
	backbutton:SetText( "Back" )
	backbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	backbutton:SetPos( 350, 3 )
	backbutton:SetSize( 50, 20 )
	backbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	backbutton.DoClick = function()
		mainframe:Close()
		DrawMainMenu( ent )
		surface.PlaySound( GetConVar( "Craft_Config_UI_Sound" ):GetString() )
	end
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for a,b in ipairs( CraftingCategory ) do
		local categorybutton = vgui.Create( "DButton", mainframescroll )
		categorybutton:SetSize( nil, 35 ) --X is ignored since it's docked to the frame already
		categorybutton:SetText( b.Name )
		categorybutton:SetFont( "Trebuchet24" )
		categorybutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
		categorybutton:Dock( TOP )
		categorybutton:DockMargin( 0, 15, 0, 5 )
		categorybutton.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, b.Color )
		end
		for k,v in pairs( CraftingTable ) do --Looks over all recipes in the main CraftingTable table
			if v.Category != b.Name then --Puts items into their respective categories
				continue
			end
			local mainbuttons = vgui.Create( "DButton", mainframescroll )
			mainbuttons:SetText( v.Name )
			mainbuttons:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
			mainbuttons:Dock( TOP )
			mainbuttons:DockMargin( 0, 0, 0, 5 )
			mainbuttons.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
			end
			mainbuttons.DoClick = function()
				chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 100, 255, 100 ), "<"..v.Name.."> ", Color( 255, 255, 255 ), v.Description )
				ply.SelectedCraftingItem = tostring( k ) --Temporarily saves the entity class name for the net message that goes through when the player presses the craft button
				ply.SelectedCraftingItemName = v.Name --Temporarily saves the actual name so it doesn't print the entity class name
				surface.PlaySound( GetConVar( "Craft_Config_Select_Sound" ):GetString() )
				mainframe:Close()
				DrawRecipes( ent ) --Refreshes the button so it shows the currently selected item
			end
		end
	end
	local selectedbutton = vgui.Create( "DButton", mainframe )
	if ply.SelectedCraftingItemName then
		selectedbutton:SetText( "Currently Selected Item: "..ply.SelectedCraftingItemName )
	else
		selectedbutton:SetText( "Currently Selected Item: N/A" )
	end
	selectedbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	selectedbutton:SetPos( 5, 465 )
	selectedbutton:SetSize( 245, 30 )
	selectedbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	local craftbutton = vgui.Create( "DButton", mainframe )
	craftbutton:SetText( "Craft Selected Item" )
	craftbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	craftbutton:Dock( BOTTOM )
	craftbutton:DockMargin( 250, 0, 0, 0 )
	craftbutton:SetSize( 245, 30 )
	craftbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	craftbutton.DoClick = function()
		if !ply.SelectedCraftingItem then
			chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 255, 255, 255 ), "Please select an item to craft." )
			surface.PlaySound( GetConVar( "Craft_Config_Fail_Sound" ):GetString() )
			return
		end
		net.Start( "StartCrafting" )
		net.WriteEntity( ent )
		net.WriteString( ply.SelectedCraftingItem ) --Sends the entity class name that was saved earlier
		net.WriteString( ply.SelectedCraftingItemName ) --Sends the actual name that was saved earlier
		net.SendToServer() --Sends the message to craft the item
		mainframe:Close()
		ply.SelectedCraftingItem = nil --Resets the entity class name
		ply.SelectedCraftingItemName = nil --Resets the actual name
	end
end

DrawMainMenu = function( ent ) --Panel that draws the main menu
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Crafting Table - Main Menu" )
	mainframe:SetSize( 300, 150 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_MENU_COLOR )
	end
	local recipesbutton = vgui.Create( "DButton", mainframe )
	recipesbutton:SetText( "View Recipes/Craft an Item" )
	recipesbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	recipesbutton:SetPos( 25, 50 )
	recipesbutton:SetSize( 250, 30 )
	recipesbutton:CenterHorizontal()
	recipesbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	recipesbutton.DoClick = function() --Button to open the recipes panel
		DrawRecipes( ent )
		mainframe:Close()
		surface.PlaySound( GetConVar( "Craft_Config_UI_Sound" ):GetString() )
    end
	local itemsbutton = vgui.Create( "DButton", mainframe )
	itemsbutton:SetText( "View Items Currently on the Table" )
	itemsbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	itemsbutton:SetPos( 25, 100 )
	itemsbutton:SetSize( 250, 30 )
	itemsbutton:CenterHorizontal()
	itemsbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	itemsbutton.DoClick = function() --Button to open the current ingredients panel
		DrawItems( ent )
		mainframe:Close()
		surface.PlaySound( GetConVar( "Craft_Config_UI_Sound" ):GetString() )
	end
end

net.Receive( "CraftingTableMenu", function( len, ply ) --Receiving the net message to open the main crafting table menu
	local ent = net.ReadEntity()
	DrawMainMenu( ent )
end )

net.Receive( "CraftMessage", function( len, ply ) --Have to network the entname into here since the client can't see it serverside
	local validfunction = net.ReadBool()
	local entname = net.ReadString()
	if validfunction then --Checks to make sure the spawn function exists, I might have it go through a default spawn function at some point instead of just erroring
		chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 255, 255, 255 ), "Successfully crafted a "..entname.." ." )
	else
		chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 255, 255, 255 ), "ERROR! Missing SpawnFunction for "..entname.." ("..ent..")" )
	end
end )
