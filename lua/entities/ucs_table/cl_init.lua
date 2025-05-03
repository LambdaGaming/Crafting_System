include( "shared.lua" )

local DrawItems, DrawRecipes, DrawMainMenu --Initialize these early so the client can see them when using the back buttons

local function DrawRecipeButtons( k, v, ply, ent, main, scroll, nocat )
	local tbl = ent:GetData()
	local mainbuttons = vgui.Create( "DButton", scroll )
	mainbuttons:SetText( v.Name )
	mainbuttons:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	if nocat then
		mainbuttons:Dock( TOP )
		mainbuttons:DockMargin( 5, 5, 5, 5 )
	end
	mainbuttons.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	mainbuttons.DoClick = function()
		chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 100, 255, 100 ), "<"..v.Name.."> ", color_white, v.Description )
		ply.SelectedCraftingItem = tostring( k )
		ply.SelectedCraftingItemName = v.Name
		surface.PlaySound( tbl.SelectSound or "buttons/lightswitch2.wav" )
		main:Close()
		DrawRecipes( ent )
	end

	local totalrequired = 0
	local totalamount = 0
	local amountimage = vgui.Create( "DImage", mainbuttons )
	amountimage:SetSize( 16, 16 )
	amountimage:CenterVertical()
	for c,d in pairs( v.Materials ) do
		if ent:GetNWInt( "Craft_"..c ) >= d then
			totalamount = totalamount + 1
		end
		totalrequired = totalrequired + 1
	end
	if totalamount >= totalrequired then
		amountimage:SetImage( "icon16/accept.png" )
	elseif math.Round( totalamount / totalrequired ) >= 0.50 then
		amountimage:SetImage( "icon16/error.png" )
	else
		amountimage:SetImage( "icon16/delete.png" )
	end

	if tbl.AllowAutomation then
		local automatecheck = vgui.Create( "DCheckBox", mainbuttons )
		automatecheck:SetPos( 20, 3 )
		if ent:GetNWBool( "CraftAutomate"..k ) then
			automatecheck:SetChecked( true )
		end
		automatecheck.OnChange = function()
			if automatecheck:GetChecked() then
				net.Start( "StartAutomate" )
				net.WriteEntity( ent )
				net.WriteString( k )
				net.WriteString( v.Name )
				net.SendToServer()
				chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", color_white, "The table will now automate production of the "..v.Name.."." )
			else
				net.Start( "StopAutomate" )
				net.WriteEntity( ent )
				net.WriteString( k )
				net.SendToServer()
				chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", color_white, "The table will no longer automate production of the "..v.Name.."." )
			end
			surface.PlaySound( tbl.SelectSound or "buttons/lightswitch2.wav" )
		end
	end
	return mainbuttons
end

local function DrawIngredientButtons( k, v, ent, main, scroll, nocat )
	local MenuReloadCooldown = 0
	local tbl = ent:GetData()
	local scrollbutton = vgui.Create( "DButton", scroll )
	if ent:GetNWInt( "Craft_"..v.Name ) == nil then --If networked int doesn't exist then just set it's value to 0 until it does
		scrollbutton:SetText( v.Name..": 0" )
	else
		scrollbutton:SetText( v.Name..": "..ent:GetNWInt( "Craft_"..k ) )
	end
	scrollbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	scrollbutton:Dock( TOP )
	if nocat then
		scrollbutton:DockMargin( 5, 5, 5, 5 )
	else
		scrollbutton:DockMargin( 0, 0, 0, 5 )
	end
	scrollbutton.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	scrollbutton.DoClick = function()
		if ent:GetNWInt( "Craft_"..k ) == nil or ent:GetNWInt( "Craft_"..k ) == 0 then
			surface.PlaySound( tbl.FailSound or "buttons/button2.wav" )
			hook.Run( "Craft_OnDropItemFail", ent )
			return --Prevents players from having negative ingredients
		end
		if MenuReloadCooldown > CurTime() then return end
		net.Start( "DropItem" )
		net.WriteEntity( ent )
		net.WriteString( k )
		net.SendToServer() --Sends the net message to drop the specified item and remove it from the table
		timer.Simple( 0.3, function() --Small timer to let the net message go through
			main:Close()
			DrawItems( ent ) --Refreshes the panel so it updates the number of materials
		end )
		MenuReloadCooldown = CurTime() + 1
	end
	return scrollbutton
end

DrawItems = function( ent ) --Panel that draws the list of materials that are on the table
	local nocategory = {}
	local categories = {}
	local tbl = ent:GetData()
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
		draw.RoundedBox( 10, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	backbutton.DoClick = function()
		mainframe:Close()
		DrawMainMenu( ent )
		surface.PlaySound( tbl.UISound or "ui/buttonclickrelease.wav" )
	end
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )

	--Read categories from ingredients
	for k,v in pairs( CraftingIngredient ) do
		if v.Category and !table.HasValue( categories, v.Category ) then
			table.insert( categories )
		end
	end

	--Generate ingredient list with categories
	for a,b in pairs( categories ) do
		local mainlist = vgui.Create( "DPanelList" )
		mainlist:SetSpacing( 5 )
		mainlist:EnableHorizontal( false )

		local categorybutton = vgui.Create( "DCollapsibleCategory", mainframescroll )
		categorybutton:SetLabel( b )
		categorybutton:Dock( TOP )
		categorybutton:DockMargin( 0, 15, 0, 5 )
		categorybutton:DockPadding( 5, 0, 5, 5 )
		categorybutton:SetContents( mainlist )
		categorybutton.Paint = function( self, w, h )
			draw.RoundedBox( 8, 0, 0, w, h, color_black ) --TODO: Replace with reference to table type color
		end

		for k,v in pairs( CraftingIngredient ) do --Looks over the keys inside the materials table
			if !v.Category and !table.HasValue( nocategory, v ) then
				table.insert( nocategory, v )
				continue
			end
			if v.Category and v.Category != b.Name or !v.Category then --Puts items into their respective categories
				continue
			end
			local mainbuttons = DrawIngredientButtons( k, v, ent, mainframe, mainframescroll )
			mainlist:AddItem( mainbuttons )
		end
	end

	--Generate ingredients that don't have a category
	for k,v in pairs( nocategory ) do
		DrawIngredientButtons( k, v, ent, mainframe, mainframescroll, true )
	end
	hook.Run( "Craft_OnIngredientsOpen", ent )
end

DrawRecipes = function( ent ) --Panel that draws the list of recipes
	local ply = LocalPlayer()
	local tbl = ent:GetData()
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
		draw.RoundedBox( 10, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	backbutton.DoClick = function()
		mainframe:Close()
		DrawMainMenu( ent )
		surface.PlaySound( tbl.UISound or "ui/buttonclickrelease.wav" )
	end
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )

	local nocategory = {}
	for a,b in ipairs( CraftingCategory ) do
		local mainlist = vgui.Create( "DPanelList" )
		mainlist:SetSpacing( 5 )
		mainlist:EnableHorizontal( false )

		local categorybutton = vgui.Create( "DCollapsibleCategory", mainframescroll )
		categorybutton:SetLabel( b.Name )
		categorybutton:Dock( TOP )
		categorybutton:DockMargin( 0, 15, 0, 5 )
		categorybutton:DockPadding( 5, 0, 5, 5 )
		categorybutton:SetContents( mainlist )
		categorybutton.Paint = function( self, w, h )
			draw.RoundedBox( 8, 0, 0, w, h, b.Color )
		end
		if b.StartCollapsed then
			categorybutton:SetExpanded( false )
		end
		categorybutton.NumEntries = 0
		for k,v in pairs( CraftingTable ) do --Looks over all recipes in the main CraftingTable table
			if !v.Category and !table.HasValue( nocategory, v ) then
				table.insert( nocategory, v )
				continue
			end
			if v.Category and v.Category != b.Name or !v.Category then --Puts items into their respective categories
				continue
			end
			local mainbuttons = DrawRecipeButtons( k, v, ply, ent, mainframe, mainframescroll )
			mainlist:AddItem( mainbuttons )
			categorybutton.NumEntries = categorybutton.NumEntries + 1
		end
		if categorybutton.NumEntries == 0 then
			categorybutton:Remove() --Remove the category if no recipes are using it
		end
	end

	for k,v in pairs( nocategory ) do
		DrawRecipeButtons( k, v, ply, ent, mainframe, mainframescroll, true )
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
		draw.RoundedBoxEx( 10, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR, true, false, true, false )
	end
	local craftbutton = vgui.Create( "DButton", mainframe )
	craftbutton:SetText( "Craft Selected Item" )
	craftbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	craftbutton:Dock( BOTTOM )
	craftbutton:DockMargin( 250, 0, 0, 0 )
	craftbutton:SetSize( 245, 30 )
	craftbutton.Paint = function( self, w, h )
		draw.RoundedBoxEx( 10, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR, false, true, false, true )
	end
	craftbutton.DoClick = function()
		if !ply.SelectedCraftingItem then
			chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", color_white, "Please select an item to craft." )
			surface.PlaySound( tbl.FailSound or "buttons/button2.wav" )
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
	hook.Run( "Craft_OnRecipesOpen", ent, ply )
end

DrawMainMenu = function( ent ) --Panel that draws the main menu
	local tbl = ent:GetData()
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
		draw.RoundedBox( 10, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	recipesbutton.DoClick = function() --Button to open the recipes panel
		DrawRecipes( ent )
		mainframe:Close()
		surface.PlaySound( tbl.UISound or "ui/buttonclickrelease.wav" )
    end
	local itemsbutton = vgui.Create( "DButton", mainframe )
	itemsbutton:SetText( "View Items Currently on the Table" )
	itemsbutton:SetTextColor( CRAFT_CONFIG_BUTTON_TEXT_COLOR )
	itemsbutton:SetPos( 25, 100 )
	itemsbutton:SetSize( 250, 30 )
	itemsbutton:CenterHorizontal()
	itemsbutton.Paint = function( self, w, h )
		draw.RoundedBox( 10, 0, 0, w, h, CRAFT_CONFIG_BUTTON_COLOR )
	end
	itemsbutton.DoClick = function() --Button to open the current ingredients panel
		DrawItems( ent )
		mainframe:Close()
		surface.PlaySound( tbl.UISound or "ui/buttonclickrelease.wav" )
	end
	hook.Run( "Craft_OnMainMenuOpen", ent )
end

net.Receive( "CraftingTableMenu", function( len ) --Receiving the net message to open the main crafting table menu
	local ent = net.ReadEntity()
	local ply = net.ReadEntity()
	local trace = ply:GetEyeTrace().Entity
	if trace != ent then return end
	DrawMainMenu( ent )
end )

net.Receive( "CraftMessage", function( len, ply )
	local txt = net.ReadString()
	local snd = net.ReadString()
	chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", color_white, txt )
	if snd then
		surface.PlaySound( snd )
	end
end )
