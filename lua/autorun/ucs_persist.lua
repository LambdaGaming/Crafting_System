local allowed = {
	["ucs_table"] = true,
	["ucs_mineable"] = true
}

local function SaveEnts()
	local saved = {}
	for k,v in ipairs( ents.FindByClass( "ucs_*" ) ) do
		if v:GetNWBool( "UCSPersist" ) then
			local class = v:GetClass()
			local typ = class == "ucs_table" and v:GetTableType() or v:GetMineableType()
			table.insert( saved, { class, typ, v:GetPos(), v:GetAngles() } )
		end
	end
	file.CreateDir( "ucs/persist" )
	file.Write( "ucs/persist/"..game.GetMap()..".json", util.TableToJSON( saved ) )
end

properties.Add( "ucschangetype", {
	MenuLabel = "Change Type",
	Order = 1600,
	PrependSpacer = true,
	MenuIcon = "icon16/brick_edit.png",
	Filter = function( self, ent, ply )
		return IsValid( ent ) and allowed[ent:GetClass()] and ply:IsAdmin()
	end,
	MenuOpen = function( self, option, ent, tr )
		local sub = option:AddSubMenu()
		local tbl = ent:GetClass() == "ucs_table" and CraftingTable or MineableEntity
		for k,v in pairs( tbl ) do
			sub:AddOption( v.Name or "Invalid Type", function() self:SetType( ent, k ) end )
		end
	end,
	Action = function() end,
	SetType = function( self, ent, typ )
		self:MsgStart()
		net.WriteEntity( ent )
		net.WriteString( typ )
		self:MsgEnd()
	end,
	Receive = function( self, len, ply )
		if !ply:IsAdmin() then return end
		local ent = net.ReadEntity()
		local typ = net.ReadString()
		local pos = ent:GetPos()
		local ang = ent:GetAngles()
		local class = ent:GetClass()
		ent:Remove()

		local e = ents.Create( class )
		e:SetPos( pos )
		e:SetAngles( ang )
		if class == "ucs_table" then
			e:SetTableType( typ )
		else
			e:SetMineableType( typ )
		end
		e:Spawn()
	end
} )

properties.Add( "ucssavetomap", {
	MenuLabel = "Save to Map",
	Order = 1601,
	MenuIcon = "icon16/drive_disk.png",
	Filter = function( self, ent, ply )
		return IsValid( ent ) and allowed[ent:GetClass()] and ply:IsAdmin() and !ent:GetNWBool( "UCSPersist" )
	end,
	Action = function( self, ent )
		self:MsgStart()
		net.WriteEntity( ent )
		self:MsgEnd()
	end,
	Receive = function( self, len, ply )
		local ent = net.ReadEntity()
		ent:SetNWBool( "UCSPersist", true )
		ent:SetMoveType( MOVETYPE_NONE )
		SaveEnts()
	end
} )

properties.Add( "ucsremovefrommap", {
	MenuLabel = "Remove From Map",
	Order = 1602,
	MenuIcon = "icon16/drive_delete.png",
	Filter = function( self, ent, ply )
		return IsValid( ent ) and allowed[ent:GetClass()] and ply:IsAdmin() and ent:GetNWBool( "UCSPersist" )
	end,
	Action = function( self, ent )
		self:MsgStart()
		net.WriteEntity( ent )
		self:MsgEnd()
	end,
	Receive = function( self, len, ply )
		local ent = net.ReadEntity()
		ent:SetNWBool( "UCSPersist", false )
		ent:SetMoveType( MOVETYPE_VPHYSICS )
		SaveEnts()
	end
} )

if SERVER then
	hook.Add( "InitPostEntity", "UCSLoadSavedEnts", function()
		local name = "ucs/persist/"..game.GetMap()..".json"
		if file.Exists( name, "DATA" ) then
			local tbl = util.JSONToTable( file.Read( name ) )
			for k,v in pairs( tbl ) do
				local e = ents.Create( v[1] )
				if v[1] == "ucs_table" then
					e:SetTableType( v[2] )
				else
					e:SetMineableType( v[2] )
				end
				e:SetPos( v[3] )
				e:SetAngles( v[4] )
				e:Spawn()
				e:SetNWBool( "UCSPersist", true )
				e:SetMoveType( MOVETYPE_NONE )
			end
			print( "Spawned "..#tbl.." UCS entities." )
		end
	end )
end
