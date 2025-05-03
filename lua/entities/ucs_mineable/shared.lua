ENT.Type = "anim"
ENT.PrintName = "Mineable Entity"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Universal Crafting System"

MineableEntity = {}

function ENT:SetupDataTables()
    self:NetworkVar( "Int", "MineableType" )
    if SERVER then
        self:SetMineableType( 0 )
    end
end

function ENT:GetData()
	local typ = self:GetTableType()
	if !MineableEntity[typ] then
		error( "Table is set to type that doesn't exist!" )
	end
	return MineableEntity[typ]
end
