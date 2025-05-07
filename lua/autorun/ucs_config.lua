--Table initializations, don't touch
CraftingTable = {}
CraftingRecipe = {}
CraftingIngredient = {}
MineableEntity = {}

--[[
This file allows you to manually configure the addon with Lua tables.
You should only do stuff here if you're familiar with Lua and need to
do something that isn't possible through the in-game config.
]]

--Template mining entity; The Health, Respawn, MinSpawn, and MaxSpawn options have fallbacks and are not required
--[[
	MineableEntity["rock"] = {
		Name = "Rock",
		Models = {
			"models/props_debris/barricade_short01a.mdl",
			"models/props_debris/barricade_short02a.mdl",
			"models/props_debris/barricade_tall01a.mdl"
		},
		Tools = { ["weapon_crowbar"] = 5, ["weapon_stunstick"] = 2 },
		Drops = { ["ucs_iron"] = 100 },
		Health = 100,
		Respawn = 300,
		MinSpawn = 2,
		MaxSpawn = 6
	}
]]

MineableEntity["rock"] = {
    Name = "Rock",
    Models = {
        "models/props_debris/barricade_short01a.mdl",
        "models/props_debris/barricade_short02a.mdl",
        "models/props_debris/barricade_tall01a.mdl"
    },
    Tools = { ["weapon_crowbar"] = 5 },
    Drops = { ["ucs_iron"] = 100 }
}

--Template crafting table; All options except name and model have fallbacks and are not required
--[[
	CraftingTable["example"] = {
		Name = "Example Table",
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
		AutomationTime = 120,
		MenuColor = Color( 49, 53, 61, 200 ),
		CategoryColor = Color( 49, 53, 61, 255 ),
		ButtonColor = Color( 230, 93, 80, 255 ),
		TextColor = color_white
	}
]]

CraftingTable["hl2"] = {
    Name = "HL2 Weapons Table",
    Model = "models/props_wasteland/controlroom_desk001b.mdl"
}

--Template Ingredient
--[[
	CraftingIngredient["entity_name"] = { --Class name of the entity goes in the brackets
		Name = "Iron", --Name that shows up in the ingredient list
		Category = "Default Ingredients", --Optional. Category the item shows up in, has to match the name of an ingredient category created below
		Types = { ["example"] = true } --List of table types that this ingredient will show up in
	}
]]

CraftingIngredient["ucs_iron"] = {
	Name = "Iron",
	Category = "Default Ingredients",
	Types = { ["hl2"] = true }
}

CraftingIngredient["ucs_wood"] = {
	Name = "Wood",
	Category = "Default Ingredients",
	Types = { ["hl2"] = true }
}

--Template recipe
--[[
	CraftingRecipe["weapon_crowbar"] = { --Entity class of the item being crafted
		Name = "Crowbar", --Name of the item, different from the item's entity name
		Description = "Requires 2 iron and 1 wood.", --Description of the item
		Category = "Tools", --Optional. Category the item shows up in, has to match the name of a category created above
        Types = { --List of table types that this recipe will show up in
			["example"] = true
		},
		Materials = { --Entities that are required to craft this item
			["ucs_iron"] = 2,
			["ucs_wood"] = 1
		},
		SpawnCheck = function( ply, self ) --Optional. Return false to prevent the player from crafting the item. Runs after the UCS_CanCraft hook
			return ply:IsAdmin(), "Optional fail message"
		end,
		SpawnOverride = function( ply, self ) --Optional. Entity class above will be ignored if this function is present
			local e = ents.Create( "weapon_crowbar" )
			e:SetPos( self:GetPos() )
			e:Spawn()
			return e
		end
	}
]]

--If you are adding new ingredients, make sure you configure them above before adding them as materials in the items below. Failure to do so will result in errors!
CraftingRecipe["weapon_pistol"] = {
	Name = "9mm Pistol",
	Description = "Requires 1 iron.",
	Category = "Pistols",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 1
	}
}

CraftingRecipe["weapon_357"] = {
	Name = ".357 Revolver",
	Description = "Requires 2 iron.",
	Category = "Pistols",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 2
	}
}

CraftingRecipe["weapon_smg1"] = {
	Name = "SMG",
	Description = "Requires 3 iron.",
	Category = "SMGs",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 3
	}
}

CraftingRecipe["weapon_ar2"] = {
	Name = "Pulse Rifle",
	Description = "Requires 4 iron.",
	Category = "Rifles",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 4
	}
}

CraftingRecipe["weapon_shotgun"] = {
	Name = "Shotgun",
	Description = "Requires 4 iron.",
	Category = "Shotguns",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 4
	}
}

CraftingRecipe["weapon_crossbow"] = {
	Name = "Crossbow",
	Description = "Requires 5 iron and 2 wood.",
	Category = "Rifles",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 5,
        ["ucs_wood"] = 2
	}
}

CraftingRecipe["weapon_rpg"] = {
	Name = "RPG",
	Description = "Requires 6 iron.",
	Category = "Explosives",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 6
	}
}

CraftingRecipe["weapon_frag"] = {
	Name = "Frag Grenade",
	Description = "Requires 5 iron.",
	Category = "Explosives",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 5
	}
}

CraftingRecipe["weapon_slam"] = {
	Name = "S.L.A.M.",
	Description = "Requires 6 iron.",
	Category = "Explosives",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 6
	}
}

CraftingRecipe["weapon_crowbar"] = {
	Name = "Crowbar",
	Description = "Requires 1 iron.",
	Category = "Tools",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 1
	}
}

CraftingRecipe["weapon_stunstick"] = {
	Name = "Stunstick",
	Description = "Requires 2 iron.",
	Category = "Tools",
	Types = { ["hl2"] = true },
	Materials = {
		["ucs_iron"] = 2
	}
}
