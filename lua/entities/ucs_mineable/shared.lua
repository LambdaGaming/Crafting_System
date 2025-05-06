ENT.Type = "anim"
ENT.PrintName = "Mineable Entity"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Universal Crafting System"

function ENT:SetupDataTables()
    self:NetworkVar( "String", "MineableType" )
    if SERVER then
        self:SetMineableType( "" )
    end
end

function ENT:GetData()
	local typ = self:GetMineableType()
	if !MineableEntity[typ] then
		error( "Table is set to type that doesn't exist!" )
	end
	return MineableEntity[typ]
end
