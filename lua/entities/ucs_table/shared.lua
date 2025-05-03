ENT.Type = "anim"
ENT.PrintName = "Crafting Table"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.Category = "Universal Crafting System"

CraftingTable = {}
CraftingRecipe = {}
CraftingIngredient = {}

function ENT:SetupDataTables()
	self:NetworkVar( "Int", "TableType" )
	if SERVER then
		self:SetTableType( 0 )
	end
end

function ENT:GetData()
	local typ = self:GetTableType()
	if !CraftingTable[typ] then
		error( "Table is set to type that doesn't exist!" )
	end
	return CraftingTable[typ]
end

local COLOR_DEFAULT = Color( 49, 53, 61, 255 ) --Color of the default categories for optimization, you can change this if you want

--TODO: Add functions so people don't have to mess with tables, like how DarkRP handles custom stuff

--Template mining entity
--[[
	MineableEntity[1] = {
		Name = "Rock",
		Models = { "" },
		Tools = { "weapon_crowbar" }
		Health = 100,
		Respawn = 300,
		MinSpawn = 2,
		MaxSpawn = 6,
	}
]]

--Template crafting table; All options except name and model have fallbacks and are thus optional
--[[
	CraftingTable[1] = {
		Name = "HL2 Weapons Table",
		Model = "models/props_wasteland/controlroom_desk001b.mdl",
		Health = 500,
		Material = "",
		PlaceSound = "",
		CraftSound = "",
		UISound = "",
		SelectSound = "",
		FailSound = "",
		DropSound = "",
		DestroySound = "",
		ShouldExplode = true,
		AllowAutomation = true,
		AutomationTime = 120
	}
]]

--Template Ingredient
--[[
	CraftingIngredient["iron"] = { --Class name of the entity goes in the brackets
		Name = "Iron", --Name that shows up in the ingredient list
		Category = "Default Ingredients" --Optional. Category the item shows up in, has to match the name of an ingredient category created below
	}
]]

CraftingIngredient["iron"] = {
	Name = "Iron",
	Category = "Default Ingredients"
}

CraftingIngredient["wood"] = {
	Name = "Wood",
	Category = "Default Ingredients"
}

--Template recipe
--[[
	CraftingRecipe["weapon_crowbar"] = { --Add the entity name of the item in the brackets with quotes
		Name = "Crowbar", --Name of the item, different from the item's entity name
		Description = "Requires 1 ball.", --Description of the item
		Category = "Tools", --Optional. Category the item shows up in, has to match the name of a category created above
		Materials = { --Entities that are required to craft this item, make sure you leave the entity names WITHOUT quotes!
			iron = 2,
			wood = 1
		},
		SpawnCheck = function( ply, self ) --This function is optional, it runs a check to see if the player can craft the item before any materials are consumed
			local blacklist = {
				["gm_construct"] = true,
				["gm_flatgrass"] = true
			}
			if blacklist[game.GetMap()] then
				ply:ChatPrint( "This item cannot be crafted on the current map." )
				return false --Example that checks to see if the player can craft the item on the current map
			end
			return true --The function always needs to return either true or false
		end,
		SpawnFunction = function( ply, self ) --In this function you are able to modify the player who is crafting, the table itself, and the item that is being crafted
			local e = ents.Create( "weapon_crowbar" ) --Replace the entity name with the one at the very top inside the brackets
			e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) ) --A negative Z coordinate is added here to prevent items from spawning on top of the table and being consumed, you'll have to change it if you use a different model otherwise keep it as it is
			e:Spawn()
			if !util.IsAllInWorld( e ) then --If the model of your item is larger than the table, consider using this to detect when it spawns outside of the map
				e:Remove()
				ply:ChatPrint( "Crafted entity spawned outside of the map. You have been refunded. Please reposition the table." )
				for k,v in pairs( CraftingTable["weapon_crowbar"].Materials ) do
					self:SetNWInt( "Craft_"..k, self:GetNWInt( "Craft_"..k ) + v )
				end
			end
		end
	}
]]

--If you are adding new ingredients, make sure you configure them above before adding them as materials in the items below. Failure to do so will result in errors!
CraftingTable["weapon_pistol"] = {
	Name = "9mm Pistol",
	Description = "Requires 1 iron.",
	Category = "Pistols",
	Materials = {
		iron = 1
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_pistol" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_357"] = {
	Name = ".357 Revolver",
	Description = "Requires 2 iron.",
	Category = "Pistols",
	Materials = {
		iron = 2
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_357" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_smg1"] = {
	Name = "SMG",
	Description = "Requires 3 iron.",
	Category = "SMGs",
	Materials = {
		iron = 3
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_smg1" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_ar2"] = {
	Name = "Pulse Rifle",
	Description = "Requires 4 iron.",
	Category = "Rifles",
	Materials = {
		iron = 4
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_ar2" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_shotgun"] = {
	Name = "Shotgun",
	Description = "Requires 4 iron.",
	Category = "Shotguns",
	Materials = {
		iron = 4
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_shotgun" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_crossbow"] = {
	Name = "Crossbow",
	Description = "Requires 5 iron and 2 wood.",
	Category = "Rifles",
	Materials = {
		iron = 5,
		wood = 2
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_crossbow" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_rpg"] = {
	Name = "RPG",
	Description = "Requires 6 iron.",
	Category = "Explosives",
	Materials = {
		iron = 6
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_rpg" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_frag"] = {
	Name = "Frag Grenade",
	Description = "Requires 5 iron.",
	Category = "Explosives",
	Materials = {
		iron = 5
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_frag" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_slam"] = {
	Name = "S.L.A.M.",
	Description = "Requires 6 iron.",
	Category = "Explosives",
	Materials = {
		iron = 6
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_slam" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_crowbar"] = {
	Name = "Crowbar",
	Description = "Requires 1 iron.",
	Category = "Tools",
	Materials = {
		iron = 1
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_crowbar" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["weapon_stunstick"] = {
	Name = "Stunstick",
	Description = "Requires 2 iron.",
	Category = "Tools",
	Materials = {
		iron = 2
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "weapon_stunstick" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}
