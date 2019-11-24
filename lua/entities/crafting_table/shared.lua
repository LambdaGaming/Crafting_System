
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crafting Table"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Crafting Table"

--Convars that allow you to change values on your singleplayer game or listen server while it's running, don't touch these unless you know what you're doing
CreateConVar( "Craft_Config_MaxHealth", 100, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The max health of the crafting table." )
CreateConVar( "Craft_Config_Model", "models/props_wasteland/controlroom_desk001b.mdl", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The model of the crafting table." )
CreateConVar( "Craft_Config_Material", "", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "The material of the crafting table. Leave blank if you want the default model texture." )
CreateConVar( "Craft_Config_Place_Sound", "physics/metal/metal_solid_impact_hard1.wav", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Sound that plays when an item is placed on the table." )
CreateConVar( "Craft_Config_Craft_Sound", "ambient/machines/catapult_throw.wav", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Sound that plays when an item is crafted." )
CreateConVar( "Craft_Config_UI_Sound", "ui/buttonclickrelease.wav", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Sound that plays when a button is pressed." )
CreateConVar( "Craft_Config_Select_Sound", "buttons/lightswitch2.wav", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Sound that plays when an item is selected." )
CreateConVar( "Craft_Config_Fail_Sound", "buttons/button2.wav", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Sound that plays when an item fails to craft." )
CreateConVar( "Craft_Config_Drop_Sound", "physics/metal/metal_canister_impact_soft1.wav", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Sound that plays when an ingredient is dropped." )
CreateConVar( "Craft_Config_Should_Explode", 1, { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Whether or not the table should explode when it's health reaches 0. 1 for true, 0 for false." )
CreateConVar( "Craft_Config_Destroy_Sound", "physics/metal/metal_box_break1.wav", { FCVAR_ARCHIVE, FCVAR_REPLICATED }, "Sound that plays when the table is destroyed." )

CraftingTable = {} --Initializes the item table, don't touch
CraftingCategory = {} --Initializes the category table, don't touch
CraftingIngredient = {} --Initializes the ingredients, don't touch

--Template Ingredient
--[[
	CraftingIngredient["iron"] = { --Class name of the entity goes in the brackets
		Name = "Iron" --Name that shows up in the ingredient list
	}
]]

CraftingIngredient["iron"] = {
	Name = "Iron"
}

CraftingIngredient["wood"] = {
	Name = "Wood"
}

--Template Category
--[[
	CraftingCategory[1] = { --Be sure to change the number, the lower the number, the higher up in the list it is
		Name = "Pistols", --Name of the category
		Color = Color( 49, 53, 61, 255 ) --Color of the category box
	}
]]

CraftingCategory[1] = {
	Name = "Pistols",
	Color = Color( 49, 53, 61, 255 )
}

CraftingCategory[2] = {
	Name = "SMGs",
	Color = Color( 49, 53, 61, 255 )
}

CraftingCategory[3] = {
	Name = "Rifles",
	Color = Color( 49, 53, 61, 255 )
}

CraftingCategory[4] = {
	Name = "Shotguns",
	Color = Color( 49, 53, 61, 255 )
}

CraftingCategory[5] = {
	Name = "Tools",
	Color = Color( 49, 53, 61, 255 )
}

--Template Crafting Item
--[[
	CraftingTable["weapon_crowbar"] = { --Add the entity name of the item in the brackets with quotes
	Name = "Crowbar", --Name of the item, different from the item's entity name
	Description = "Requires 1 ball.", --Description of the item
	Category = "Tools", --Category the item shows up in, has to match the name of a category created above
	Materials = { --Entities that are required to craft this item, make sure you leave the entity names WITHOUT quotes!
		iron = 2,
		wood = 1
	},
	SpawnFunction = --Function to spawn the item, don't modify anything outside of the entity name unless you know what you're doing
		function( ply, self ) --In this function you are able to modify the player who is crafting, the table itself, and the item that is being crafted
			local e = ents.Create( "weapon_crowbar" ) --Replace the entity name with the one at the very top inside the brackets
			e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) ) --A negative Z coordinate is added here to prevent items from spawning on top of the table and being consumed, you'll have to change it if you use a different model otherwise keep it as it is
			e:Spawn()
		end
	}
]]

--If you are adding new ingredients, make sure you configure them above before adding them as materials in the items below. Failure to do so will result in errors!

CraftingTable["weapon_glock2"] = {
	Name = "Glock",
	Description = "Requires 1 iron.",
	Category = "Pistols",
	Materials = {
		iron = 1
	},
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "weapon_fiveseven2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}
