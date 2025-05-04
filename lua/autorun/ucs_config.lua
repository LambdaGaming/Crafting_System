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
	MineableEntity[1] = {
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

MineableEntity[1] = {
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
		AutomationTime = 120,
		MenuColor = Color( 49, 53, 61, 200 ),
		CategoryColor = Color( 49, 53, 61, 255 ),
		ButtonColor = Color( 230, 93, 80, 255 ),
		TextColor = color_white
	}
]]

CraftingTable[1] = {
    Name = "HL2 Weapons Table",
    Model = "models/props_wasteland/controlroom_desk001b.mdl"
}

--Template Ingredient
--[[
	CraftingIngredient["iron"] = { --Class name of the entity goes in the brackets
		Name = "Iron", --Name that shows up in the ingredient list
		Category = "Default Ingredients" --Optional. Category the item shows up in, has to match the name of an ingredient category created below
	}
]]

CraftingIngredient["ucs_iron"] = {
	Name = "Iron",
	Category = "Default Ingredients"
}

CraftingIngredient["ucs_wood"] = {
	Name = "Wood",
	Category = "Default Ingredients"
}

--Template recipe
--[[
	CraftingRecipe[1] = {
		Name = "Crowbar", --Name of the item, different from the item's entity name
		Description = "Requires 2 iron and 1 wood.", --Description of the item
		Category = "Tools", --Optional. Category the item shows up in, has to match the name of a category created above
        Entity = "weapon_crowbar", --Name of the entity that will be spawned. Does nothing if using Weapon parameter
        Weapon = "weapon_crowbar", --Name of the weapon to give to the player. Does nothing if using Entity parameter
        Types = { 1 }, --List of table types that this recipe will show up in
		Materials = { --Entities that are required to craft this item
			["ucs_iron"] = 2,
			["ucs_wood"] = 1
		},
		SpawnOverride = function( ply, self ) --Optional. Causes Entity and Weapon parameters to be ignored
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
	Weapon = "weapon_pistol",
	Materials = {
		["ucs_iron"] = 1
	}
}

CraftingRecipe["weapon_357"] = {
	Name = ".357 Revolver",
	Description = "Requires 2 iron.",
	Category = "Pistols",
	Weapon = "weapon_357",
	Materials = {
		["ucs_iron"] = 2
	}
}

CraftingRecipe["weapon_smg1"] = {
	Name = "SMG",
	Description = "Requires 3 iron.",
	Category = "SMGs",
	Weapon = "weapon_smg1",
	Materials = {
		["ucs_iron"] = 3
	}
}

CraftingRecipe["weapon_ar2"] = {
	Name = "Pulse Rifle",
	Description = "Requires 4 iron.",
	Category = "Rifles",
	Weapon = "weapon_ar2",
	Materials = {
		["ucs_iron"] = 4
	}
}

CraftingRecipe["weapon_shotgun"] = {
	Name = "Shotgun",
	Description = "Requires 4 iron.",
	Category = "Shotguns",
	Weapon = "weapon_shotgun",
	Materials = {
		["ucs_iron"] = 4
	}
}

CraftingRecipe["weapon_crossbow"] = {
	Name = "Crossbow",
	Description = "Requires 5 iron and 2 wood.",
	Category = "Rifles",
	Weapon = "weapon_crossbow",
	Materials = {
		["ucs_iron"] = 5,
        ["ucs_wood"] = 2
	}
}

CraftingRecipe["weapon_rpg"] = {
	Name = "RPG",
	Description = "Requires 6 iron.",
	Category = "Explosives",
	Weapon = "weapon_rpg",
	Materials = {
		["ucs_iron"] = 6
	}
}

CraftingRecipe["weapon_frag"] = {
	Name = "Frag Grenade",
	Description = "Requires 5 iron.",
	Category = "Explosives",
	Weapon = "weapon_frag",
	Materials = {
		["ucs_iron"] = 5
	}
}

CraftingRecipe["weapon_slam"] = {
	Name = "S.L.A.M.",
	Description = "Requires 6 iron.",
	Category = "Explosives",
	Weapon = "weapon_slam",
	Materials = {
		["ucs_iron"] = 6
	}
}

CraftingRecipe["weapon_crowbar"] = {
	Name = "Crowbar",
	Description = "Requires 1 iron.",
	Category = "Tools",
	Weapon = "weapon_crowbar",
	Materials = {
		["ucs_iron"] = 1
	}
}

CraftingRecipe["weapon_stunstick"] = {
	Name = "Stunstick",
	Description = "Requires 2 iron.",
	Category = "Tools",
	Weapon = "weapon_stunstick",
	Materials = {
		["ucs_iron"] = 2
	}
}
