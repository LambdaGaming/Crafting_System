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

local version = "2.0"
print( "Universal Crafting System v"..version.." by OPGman successfully loaded.\n" )
