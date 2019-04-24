
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crafting Table"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Crafting Table"

ENT.CraftingItems = {}
CraftingTable = {}

CraftingTable["weapon_crowbar"] = {
	Name = "Crowbar",
	Description = "Requires 1 ball.",
	Materials = {
		"sent_ball"
	},
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_crowbar" )
			e:SetPos( self:GetPos() - Vector( 0, 0, 45 ) )
			e:Spawn()
		end
}