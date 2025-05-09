ENT.Type = "anim"
ENT.PrintName = "Crafting Table"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Universal Crafting System"

function ENT:SetupDataTables()
	self:NetworkVar( "String", "TableType" )
	if SERVER then
		self:SetTableType( "" )
	end
end

function ENT:GetData()
	local typ = self:GetTableType()
	if !CraftingTable[typ] then
		error( "Table is set to type that doesn't exist!" )
	end
	return CraftingTable[typ]
end

properties.Add( "ucschangetype", {
	MenuLabel = "Change Type",
	Order = 1600,
	PrependSpacer = true,
	MenuIcon = "icon16/brick_edit.png",
	Filter = function( self, ent, ply )
		local allowed = {
			["ucs_table"] = true,
			["ucs_mineable"] = true
		}
		return IsValid( ent ) and allowed[ent:GetClass()] and ply:IsAdmin()
	end,
	MenuOpen = function( self, option, ent, tr )
		local sub = option:AddSubMenu()
		local tbl = ent:GetClass() == "ucs_table" and CraftingTable or MineableEntity
		for k,v in pairs( tbl ) do
			local opt = sub:AddOption( v.Name or "Invalid Type", function()
				self:SetType( ent, k )
			end )
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

local version = "2.0"
print( "Universal Crafting System v"..version.." by OPGman successfully loaded.\n" )
