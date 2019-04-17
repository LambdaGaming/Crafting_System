ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crafting Table"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:Initialize()
	self.CraftingItems = {}
end

CraftingTable = {}

CraftingTable["weapon_crowbar"] = {
	Name = "Crowbar",
	Materials = {
		"weapon_pistol"
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_pistol" )
			e:SetPos( self:GetPos() - Vector( 0, 0, 45 ) )
			e:Spawn()
		end
}