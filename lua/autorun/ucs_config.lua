--Global table initializations, don't touch
CraftingTable = {}
CraftingRecipe = {}
CraftingIngredient = {}
MineableEntity = {}

--[[
This file allows you to configure the addon with Lua tables. You don't necessarily need to use this file to configure
the addon. You can use any file as long as it automatically runs and has a shared scope. If you run into issues with
the global tables not being declared early enough, put your code inside an Initialize hook.
]]

--Template mining entity; The Health, Respawn, MinSpawn, and MaxSpawn options have fallbacks and are not required
--[[
MineableEntity["rock"] = { --Name must be unique
	Name = "Rock", --Name that will float above the entity. Does not need to be unique
	Models = { --List of models that get randomly selected when the entity spawns
		"models/props_debris/barricade_short01a.mdl",
		"models/props_debris/barricade_short02a.mdl",
		"models/props_debris/barricade_tall01a.mdl"
	},
	Tools = { --List of weapons that are allowed to damage this entity
		["weapon_crowbar"] = 5, --Class name of the weapon goes in the quotes. The number represents a damage amount override, which you can set to 0 to disable
		["weapon_stunstick"] = 2
	},
	Drops = { --List of entities that can be dropped when mining is complete
		["ucs_iron"] = 100 --Class name of the entity goes in the quotes. The number represents the chance of that entity being spawned
	},
	Health = 100, --Max health that the entity spawns with
	Respawn = 300, --Time in seconds that it takes for the entity to respawn after being mined
	MinSpawn = 2, --Minimum amount of drops that the entity will provide when mined
	MaxSpawn = 6 --Max amount of drops, must be higher or equal to MinSpawn
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
CraftingTable["example"] = { --Name must be unique
	Name = "Example Table", --Name that will float above the entity and appear in the menu. Does not need to be unique
	Model = "models/props_wasteland/controlroom_desk001b.mdl", --Model the table will spawn with
	Health = 500, --Max health of the table
	Material = "", --Material override
	PlaceSound = "", --Sound that plays when an ingredient is placed on the table
	CraftSound = "", --Sound that plays when an item is crafted
	UISound = "", --Sound that plays when a button is pressed in the menu
	SelectSound = "", --Sound that plays when an item is selected in the menu
	FailSound = "", --Sound that plays when an action in the menu fails
	DropSound = "", --Sound that plays when an ingredient is manually removed from the table
	DestroySound = "", --Sound that plays when a table is destroyed
	ShouldExplode = true, --Set to true to allow the table to explode when its destroyed
	AllowAutomation = true, --Set to true to allow users to automate crafting with this table
	AutomationTime = 120, --Time it takes in seconds for an automated craft to complete
	MenuColor = Color( 49, 53, 61, 200 ), --Color of the menu background
	CategoryColor = Color( 49, 53, 61, 255 ), --Color of the categories
	ButtonColor = Color( 230, 93, 80, 255 ), --Color of the buttons
	TextColor = color_white --Color of the text
}
]]

CraftingTable["hl2"] = {
    Name = "HL2 Weapons Table",
    Model = "models/props_wasteland/controlroom_desk001b.mdl"
}

--Template Ingredient
--[[
CraftingIngredient["entity_name"] = { --Class name of the ingredient's entity must go in the quotes
	Name = "Iron", --Name that shows up in the ingredient list, doesn't have to be unique but probably should be
	Category = "Default Ingredients", --Optional. Category the item shows up in
	Types = { --List of table types that this ingredient will show up in
		["example"] = true, --We set this to true so the addon knows the index exists. It's done this way for optimization reasons
		["hl2"] = true
	}
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
	Description = "Requires 2 iron and 1 wood.", --Description of the item. Required ingredients should be listed here
	Category = "Tools", --Optional. Category the item shows up in, has to match the name of a category created above
	Types = { --List of table types that this recipe will show up in
		["example"] = true
	},
	Materials = { --Entities that are required to craft this item
		["ucs_iron"] = 2, --Class name of the entity goes in quotes. The number represents the amount required
		["ucs_wood"] = 1
	},
	SpawnCheck = function( ply, self ) --Optional. Return false to prevent the player from crafting the item. Runs after the UCS_CanCraft hook
		return ply:IsAdmin(), "Optional fail message"
	end,
	SpawnOverride = function( ply, self ) --Optional. This will override the default spawn function so you can define custom behaviors
		local e = ents.Create( "weapon_crowbar" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		return e --You should return the created entity so it can be referenced by the UCS_OnCrafted hook
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
