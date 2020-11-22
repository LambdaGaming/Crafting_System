
ENT.Type = "anim"
ENT.PrintName = "Crafting Table"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Crafting Table"

--Convars that allow you to change values on your singleplayer game or listen server while it's running, don't touch these unless you know what you're doing
CreateConVar( "Craft_Config_MaxHealth", 100, { FCVAR_ARCHIVE }, "The max health of the crafting table." )
CreateConVar( "Craft_Config_Model", "models/props_wasteland/controlroom_desk001b.mdl", { FCVAR_ARCHIVE }, "The model of the crafting table." )
CreateConVar( "Craft_Config_Material", "", { FCVAR_ARCHIVE }, "The material of the crafting table. Leave blank if you want the default model texture." )
CreateConVar( "Craft_Config_Place_Sound", "physics/metal/metal_solid_impact_hard1.wav", { FCVAR_ARCHIVE }, "Sound that plays when an item is placed on the table." )
CreateConVar( "Craft_Config_Craft_Sound", "ambient/machines/catapult_throw.wav", { FCVAR_ARCHIVE }, "Sound that plays when an item is crafted." )
CreateConVar( "Craft_Config_UI_Sound", "ui/buttonclickrelease.wav", { FCVAR_ARCHIVE }, "Sound that plays when a button is pressed." )
CreateConVar( "Craft_Config_Select_Sound", "buttons/lightswitch2.wav", { FCVAR_ARCHIVE }, "Sound that plays when an item is selected." )
CreateConVar( "Craft_Config_Fail_Sound", "buttons/button2.wav", { FCVAR_ARCHIVE }, "Sound that plays when an item fails to craft." )
CreateConVar( "Craft_Config_Drop_Sound", "physics/metal/metal_canister_impact_soft1.wav", { FCVAR_ARCHIVE }, "Sound that plays when an ingredient is dropped." )
CreateConVar( "Craft_Config_Should_Explode", 1, { FCVAR_ARCHIVE }, "Whether or not the table should explode when it's health reaches 0. 1 for true, 0 for false." )
CreateConVar( "Craft_Config_Destroy_Sound", "physics/metal/metal_box_break1.wav", { FCVAR_ARCHIVE }, "Sound that plays when the table is destroyed." )
CreateConVar( "Craft_Config_Tree_Health", 100, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The max health of the trees." )
CreateConVar( "Craft_Config_Tree_Respawn", 300, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The respawn time for trees in seconds." )
CreateConVar( "Craft_Config_Min_Spawn", 2, { FCVAR_ARCHIVE }, "Minimum number of entities that can be mined from a rock or tree." )
CreateConVar( "Craft_Config_Max_Spawn", 6, { FCVAR_ARCHIVE }, "Maximum number of entities that can be mined from a rock or tree." )
CreateConVar( "Craft_Config_Rock_Health", 100, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The max health of the rocks." )
CreateConVar( "Craft_Config_Rock_Respawn", 300, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The respawn time for rocks in seconds." )

CraftingTable = {} --Initializes the item table, don't touch
CraftingCategory = {} --Initializes the category table, don't touch
CraftingIngredient = {} --Initializes the ingredients, don't touch
IngredientCategory = {} --Initializes the ingredient category table, don't touch
local COLOR_DEFAULT = Color( 49, 53, 61, 255 ) --Color of the default categories for optimization, you can change this if you want

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

--Template recipe category
--[[
	CraftingCategory[1] = { --Be sure to change the number, the lower the number, the higher up in the list it is
		Name = "Pistols", --Name of the category
		Color = COLOR_DEFAULT, --Color of the category box
		StartCollapsed = false --Optional, set to true if you want the category to start collapsed
	}
]]

CraftingCategory[1] = {
	Name = "Pistols",
	Color = COLOR_DEFAULT
}

CraftingCategory[2] = {
	Name = "SMGs",
	Color = COLOR_DEFAULT
}

CraftingCategory[3] = {
	Name = "Rifles",
	Color = COLOR_DEFAULT
}

CraftingCategory[4] = {
	Name = "Shotguns",
	Color = COLOR_DEFAULT
}

CraftingCategory[5] = {
	Name = "Tools",
	Color = COLOR_DEFAULT
}

CraftingCategory[6] = {
	Name = "Explosives",
	Color = COLOR_DEFAULT
}

--Template ingredient category
--[[
	IngredientCategory[1] = { --Be sure to change the number, the lower the number, the higher up in the list it is
		Name = "Default Ingredients", --Name of the category
		Color = COLOR_DEFAULT, --Color of the category box
		StartCollapsed = false --Optional, set to true if you want the category to start collapsed
	}
]]

IngredientCategory[1] = {
	Name = "Default Ingredients",
	Color = COLOR_DEFAULT
}

--Template Crafting Item
--[[
	CraftingTable["weapon_crowbar"] = { --Add the entity name of the item in the brackets with quotes
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

if DarkRP then
	CraftingTable["weapon_glock2"] = {
		Name = "Glock",
		Description = "Requires 1 iron.",
		Category = "Pistols",
		Materials = {
			iron = 1
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_glock2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["weapon_m42"] = {
		Name = "M4",
		Description = "Requires 3 iron.",
		Category = "Rifles",
		Materials = {
			iron = 3
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_m42" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["weapon_mac102"] = {
		Name = "MAC 10",
		Description = "Requires 2 iron.",
		Category = "SMGs",
		Materials = {
			iron = 2
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_mac102" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["weapon_mp52"] = {
		Name = "MP5",
		Description = "Requires 2 iron.",
		Category = "SMGs",
		Materials = {
			iron = 2
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_mp52" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["weapon_p2282"] = {
		Name = "P228",
		Description = "Requires 1 iron.",
		Category = "Pistols",
		Materials = {
			iron = 1
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_p2282" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["weapon_pumpshotgun2"] = {
		Name = "Pump Shotgun",
		Description = "Requires 4 iron.",
		Category = "Shotguns",
		Materials = {
			iron = 4
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_pumpshotgun2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["lockpick"] = {
		Name = "Lockpick",
		Description = "Requires 1 iron.",
		Category = "Tools",
		Materials = {
			iron = 1
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "lockpick" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["ls_sniper"] = {
		Name = "Silenced Sniper Rifle",
		Description = "Requires 5 iron.",
		Category = "Rifles",
		Materials = {
			iron = 5
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ls_sniper" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["weapon_ak472"] = {
		Name = "AK-47",
		Description = "Requires 4 iron and 2 wood.",
		Category = "Rifles",
		Materials = {
			iron = 4,
			wood = 2
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_ak472" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["weapon_deagle2"] = {
		Name = "Deagle",
		Description = "Requires 2 iron.",
		Category = "Pistols",
		Materials = {
			iron = 2
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_deagle" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}

	CraftingTable["weapon_fiveseven2"] = {
		Name = "FiveSeven",
		Description = "Requires 1 iron.",
		Category = "Pistols",
		Materials = {
			iron = 1
		},
		SpawnFunction = function( ply, self )
			local e = ents.Create( "weapon_fiveseven2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
	}
else
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
end
