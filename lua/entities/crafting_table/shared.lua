
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crafting Table"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Crafting Table"

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "TableType" ) --Access and write to using ent:GetTableType() and ent:SetTableType()
end

--[[
	Types:
	1 - Rebel
	2 - Biochemist
	3 - Weapons Engineer
	4 - Combine
]]

CraftingTable = {}
CraftingCategory = {}
CraftingIngredient = {}

--Template Ingredient
--[[
	CraftingIngredient["iron"] = {
		Name = "Iron",
		Type = 1
	}
]]

CraftingIngredient["ironbar"] = {
	Name = "Iron",
	Type = { 1, 4 }
}

CraftingIngredient["wrench"] = {
	Name = "Wrench",
	Type = { 1, 4 }
}

CraftingIngredient["wood"] = {
	Name = "Wood",
	Type = { 1 }
}

CraftingIngredient["xen_iron"] = {
	Name = "Xen Iron",
	Type = { 2, 3 }
}

CraftingIngredient["xen_iron_refined"] = {
	Name = "Refined Xen Iron",
	Type = { 2, 3 }
}

CraftingIngredient["organic_matter"] = {
	Name = "Organic Matter",
	Type = { 2, 3 }
}

CraftingIngredient["organic_matter_rare"] = {
	Name = "Rare Organic Matter",
	Type = { 3 }
}

CraftingIngredient["crystal_harvested"] = {
	Name = "Harvested Crystal",
	Type = { 2, 3 }
}

CraftingIngredient["crystal_fragment"] = {
	Name = "Crystal Fragment",
	Type = { 3 }
}

--Template Category
--[[
	CraftingCategory[1] = { --Be sure to change the number, the lower the number, the higher up in the list it is
		Name = "Pistols", --Name of the category
		Color = Color( 49, 53, 61, 255 ) --Color of the category box
	}
]]

--Rebel categories
CraftingCategory[1] = {
	Name = "Pistols",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

CraftingCategory[2] = {
	Name = "SMGs",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

CraftingCategory[3] = {
	Name = "Rifles",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

CraftingCategory[4] = {
	Name = "Shotguns",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

CraftingCategory[5] = {
	Name = "Tools",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

CraftingCategory[6] = {
	Name = "Crafting Ingredients",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

CraftingCategory[7] = {
	Name = "Ammo",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

CraftingCategory[8] = {
	Name = "Explosives",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

CraftingCategory[9] = {
	Name = "Traps",
	Color = Color( 49, 53, 61, 255 ),
	Type = 1
}

--Biochemist categories
CraftingCategory[10] = {
	Name = "Creatures",
	Color = Color( 49, 53, 61, 255 ),
	Type = 2
}

CraftingCategory[11] = {
	Name = "Bioweapons",
	Color = Color( 49, 53, 61, 255 ),
	Type = 2
}

--Weapons engineer categories
CraftingCategory[12] = {
	Name = "Normal Weapons",
	Color = Color( 49, 53, 61, 255 ),
	Type = 3
}

CraftingCategory[13] = {
	Name = "Prototype Weapons",
	Color = Color( 49, 53, 61, 255 ),
	Type = 3
}

CraftingCategory[14] = {
	Name = "Unusual Weapons",
	Color = Color( 49, 53, 61, 255 ),
	Type = 3
}

--Combine categories
CraftingCategory[15] = {
	Name = "Turrets",
	Color = Color( 49, 53, 61, 255 ),
	Type = 4
}

CraftingCategory[16] = {
	Name = "Turret Ammo",
	Color = Color( 49, 53, 61, 255 ),
	Type = 4
}

CraftingCategory[17] = {
	Name = "Turret Tools",
	Color = Color( 49, 53, 61, 255 ),
	Type = 4
}

CraftingCategory[18] = {
	Name = "Other",
	Color = Color( 49, 53, 61, 255 ),
	Type = 4
}

--Template Item
--[[
	CraftingTable["weapon_crowbar"] = { --Add the entity name of the item in the brackets with quotes
	Name = "Crowbar", --Name of the item, different from the item's entity name
	Description = "Requires 1 ball.", --Description of the item
	Materials = { --Entities that are required to craft this item, make sure you leave the entity names WITHOUT quotes!
		iron = 2,
		wood = 1
	},
	Type = 1, --Lets you set the type of the item to match up with the data table above so you can have one table entity for multiple sets of items, keep this at 1 if you only want to use 1 set of items for all players
	SpawnFunction = --Function to spawn the item, don't modify anything outside of the entity name unless you know what you're doing
		function( ply, self ) --In this function you are able to modify the player who is crafting, the table itself, and the item that is being crafted
			local e = ents.Create( "weapon_crowbar" ) --Replace the entity name with the one at the very top inside the brackets
			e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) ) --A negative Z coordinate is added here to prevent items from spawning on top of the table and being consumed, you'll have to change it if you use a different model otherwise keep it as it is
			e:Spawn()
		end
	}
]]

--Rebel crafting items

CraftingTable["weapon_pistol"] = {
	Name = "Civil Protection Pistol",
	Description = "Requires 3 iron.",
	Materials = {
		ironbar = 3
	},
	Type = 1,
	Category = "Pistols",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_pistol" )
		end
}

CraftingTable["weapon_crowbar"] = {
	Name = "Crowbar",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	Category = "Tools",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_crowbar" )
		end
}

CraftingTable["weapon_smg1"] = {
	Name = "Combine SMG",
	Description = "Requires 2 iron and 1 wrench.",
	Materials = {
		ironbar = 2,
		wrench = 1
	},
	Type = 1,
	Category = "SMGs",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_smg1" )
		end
}

CraftingTable["weapon_ar2"] = {
	Name = "AR2",
	Description = "Requires 3 iron and 2 wrenches.",
	Materials = {
		ironbar = 3,
		wrench = 2
	},
	Type = 1,
	Category = "Rifles",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_ar2" )
		end
}

CraftingTable["weapon_crossbow"] = {
	Name = "Makeshift Crossbow",
	Description = "Requires 4 iron and 3 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 3
	},
	Type = 1,
	Category = "Rifles",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_crossbow" )
		end
}

CraftingTable["wrench"] = {
	Name = "Wrench",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	Category = "Crafting Ingredients",
	SpawnFunction =
		function( ply, self )
			ply:Give( "wrench" )
		end
}

CraftingTable["weapon_bp_sniper"] = {
	Name = "Combine Sniper Rifle",
	Description = "Requires 4 iron and 4 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 4
	},
	Type = 1,
	Category = "Rifles",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_bp_sniper" )
		end
}

CraftingTable["item_ammo_pistol"] = {
	Name = "Pistol Ammo",
	Description = "Requires 1 iron.",
	Materials = {
		ironbar = 1
	},
	Type = 1,
	Category = "Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_ammo_pistol" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["item_ammo_smg1"] = {
	Name = "SMG Ammo",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	Category = "Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_ammo_smg1" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["item_box_buckshot"] = {
	Name = "Shotgun Ammo",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	Category = "Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_box_buckshot" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["item_ammo_crossbow"] = {
	Name = "Crossbow Ammo",
	Description = "Requires 3 iron.",
	Materials = {
		ironbar = 3
	},
	Type = 1,
	Category = "Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_ammo_crossbow" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["item_ammo_ar2"] = {
	Name = "AR2 Ammo",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	Category = "Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_ammo_ar2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["bp_sniper_ammo"] = {
	Name = "Sniper Ammo",
	Description = "Requires 3 iron.",
	Materials = {
		ironbar = 3
	},
	Type = 1,
	Category = "Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "bp_sniper_ammo" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["lockpick"] = {
	Name = "Lockpick",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	Category = "Tools",
	SpawnFunction =
		function( ply, self )
			ply:Give( "lockpick" )
		end
}

CraftingTable["weapon_shotgun"] = {
	Name = "Shotgun",
	Description = "Requires 2 iron and 2 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 2
	},
	Type = 1,
	Category = "Shotguns",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_shotgun" )
		end
}

CraftingTable["weapon_rpg"] = {
	Name = "RPG",
	Description = "Requires 5 iron and 4 wrenches.",
	Materials = {
		ironbar = 5,
		wrench = 4
	},
	Type = 1,
	Category = "Explosives",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_rpg" )
		end
}

CraftingTable["rebel_teleporter"] = {
	Name = "Resistance Teleporter",
	Description = "Requires 8 iron and 5 wrenches.",
	Materials = {
		ironbar = 8,
		wrench = 5
	},
	Type = 1,
	Category = "Tools",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "rebel_teleporter" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["two_way_teleporter"] = {
	Name = "Two-Way Teleporter",
	Description = "Requires 4 iron and 2 wrenches. (2 need to be crafted for them to work.)",
	Materials = {
		ironbar = 4,
		wrench = 2
	},
	Type = 1,
	Category = "Tools",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "two_way_teleporter" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_frag"] = {
	Name = "Frag Grenade",
	Description = "Requires 3 iron and 2 wrenches.",
	Materials = {
		ironbar = 3,
		wrench = 2
	},
	Type = 1,
	Category = "Explosives",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_frag" )
		end
}

CraftingTable["weapon_grenadeplacer"] = {
	Name = "Tripwire Grenade",
	Description = "Requires 3 iron and 1 wrench.",
	Materials = {
		ironbar = 3,
		wrench = 1
	},
	Type = 1,
	Category = "Traps",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_grenadeplacer" )
		end
}

CraftingTable["bouncingmine"] = {
	Name = "Anti-Personnel Mine",
	Description = "Requires 5 iron and 4 wrenches.",
	Materials = {
		ironbar = 5,
		wrench = 4
	},
	Type = 1,
	Category = "Traps",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "bouncingmine" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["springgun"] = {
	Name = "Tripwire Spring Gun",
	Description = "Requires 5 iron and 4 wrenches.",
	Materials = {
		ironbar = 5,
		wrench = 2
	},
	Type = 1,
	Category = "Traps",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "springgun" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["tripwireextender"] = {
	Name = "Tripwire Extender",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	Category = "Traps",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "tripwireextender" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

if game.GetMap() == "rp_ineu_valley2_v1a" or game.GetMap() == "gm_boreas" then
	CraftingTable["ent_jack_sleepinbag_rebel"] = {
		Name = "Sleeping Bag",
		Description = "Requires 2 iron and 4 wood.",
		Materials = {
			ironbar = 2,
			wood = 4
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_sleepinbag" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_terminal_rebel"] = {
		Name = "Sentry Terminal",
		Description = "Requires 3 iron and 3 wrenches.",
		Materials = {
			ironbar = 3,
			wrench = 3
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_terminal" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretammobox_9mm_rebel"] = {
		Name = "9mm Sentry Ammo",
		Description = "Requires 3 iron.",
		Materials = {
			ironbar = 3
		},
		Type = 1,
		Category = "Ammo",
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretammobox_9mm" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretammobox_22_rebel"] = {
		Name = ".22 LR Sentry Ammo",
		Description = "Requires 2 iron.",
		Materials = {
			ironbar = 2
		},
		Type = 1,
		Category = "Ammo",
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretammobox_22" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretammobox_556_rebel"] = {
		Name = "5.56 Sentry Ammo",
		Description = "Requires 4 iron and 1 wrench.",
		Materials = {
			ironbar = 4,
			wrench = 1
		},
		Type = 1,
		Category = "Ammo",
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretammobox_556" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretammobox_762_rebel"] = {
		Name = "7.62 Sentry Ammo",
		Description = "Requires 4 iron and 3 wrenches.",
		Materials = {
			ironbar = 4,
			wrench = 3
		},
		Type = 1,
		Category = "Ammo",
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretammobox_762" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretbattery_rebel"] = {
		Name = "Sentry Battery",
		Description = "Requires 2 iron and 2 wrenches.",
		Materials = {
			ironbar = 2,
			wrench = 2
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretbattery" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretrepairkit_rebel"] = {
		Name = "Sentry Repair Kit",
		Description = "Requires 4 iron and 4 wrenches.",
		Materials = {
			ironbar = 4,
			wrench = 4
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretrepairkit" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}
end

--Biochemist crafting items

CraftingTable["npc_headcrab_black"] = {
	Name = "Poison Headcrab",
	Description = "Requires 2 organic matter.",
	Materials = {
		organic_matter = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "npc_headcrab_black" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["npc_headcrab_fast"] = {
	Name = "Fast Headcrab",
	Description = "Requires 2 organic matter.",
	Materials = {
		organic_matter = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "npc_headcrab_fast" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["monster_agrunt"] = {
	Name = "Alien Grunt",
	Description = "Requires 3 organic matter and 2 xen iron.",
	Materials = {
		organic_matter = 3,
		xen_iron = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "monster_agrunt" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["monster_controller"] = {
	Name = "Alien Controller",
	Description = "Requires 5 organic matter and 2 xen iron.",
	Materials = {
		organic_matter = 5,
		xen_iron = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "monster_controller" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_barnacle"] = {
	Name = "Handheld Barnacle",
	Description = "Requires 3 organic matter and 1 harvested crystal.",
	Materials = {
		organic_matter = 3,
		crystal_harvested = 1
	},
	Type = 2,
	Category = "Bioweapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_barnacle" )
		end
}

CraftingTable["weapon_chumtoad"] = {
	Name = "Chumtoad",
	Description = "Requires 3 organic matter, 1 xen iron, and 1 harvested crystal.",
	Materials = {
		organic_matter = 3,
		crystal_harvested = 1,
		xen_iron = 1
	},
	Type = 2,
	Category = "Bioweapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_chumtoad" )
		end
}

CraftingTable["weapon_hornetgun"] = {
	Name = "Hivehand",
	Description = "Requires 2 organic matter, 2 xen iron, and 1 harvested crystal.",
	Materials = {
		organic_matter = 2,
		crystal_harvested = 1,
		xen_iron = 2
	},
	Type = 2,
	Category = "Bioweapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_hornetgun" )
		end
}

CraftingTable["weapon_possessor"] = {
	Name = "Possessor",
	Description = "Requires 2 organic matter, 2 xen iron, 1 rare organic matter, 1 refined xen iron, and 1 harvested crystal.",
	Materials = {
		organic_matter = 2,
		crystal_harvested = 1,
		xen_iron = 2,
		organic_matter_rare = 1,
		xen_iron_refined = 1
	},
	Type = 2,
	Category = "Bioweapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_possessor" )
		end
}

CraftingTable["weapon_shockrifle"] = {
	Name = "Shock Rifle",
	Description = "Requires 2 organic matter, 3 xen iron, 1 rare organic matter, and 1 harvested crystal.",
	Materials = {
		organic_matter = 2,
		crystal_harvested = 1,
		xen_iron = 1,
		organic_matter_rare = 1
	},
	Type = 2,
	Category = "Bioweapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_shockrifle" )
		end
}

CraftingTable["weapon_snark"] = {
	Name = "Snark",
	Description = "Requires 3 organic matter, 3 xen iron, and 1 harvested crystal.",
	Materials = {
		organic_matter = 3,
		crystal_harvested = 1,
		xen_iron = 3
	},
	Type = 2,
	Category = "Bioweapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_snark" )
		end
}

CraftingTable["weapon_sporelauncher"] = {
	Name = "Spore Launcher",
	Description = "Requires 4 organic matter, 2 xen iron, 1 rare organic matter, and 1 harvested crystal.",
	Materials = {
		organic_matter = 4,
		crystal_harvested = 1,
		xen_iron = 2,
		organic_matter_rare = 1
	},
	Type = 2,
	Category = "Bioweapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_sporelauncher" )
		end
}

--Weapons engineer crafting items

CraftingTable["weapon_357_hl"] = {
	Name = "357 Magnum",
	Description = "Requires 4 xen iron.",
	Materials = {
		xen_iron = 4
	},
	Type = 3,
	Category = "Normal Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_357_hl" )
		end
}

CraftingTable["weapon_crossbow_hl"] = {
	Name = "Crossbow",
	Description = "Requires 4 xen iron and 1 refined xen iron.",
	Materials = {
		xen_iron = 4,
		xen_iron_refined = 1
	},
	Type = 3,
	Category = "Normal Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_crossbow_hl" )
		end
}

CraftingTable["weapon_egon"] = {
	Name = "Gluon Gun",
	Description = "Requires 2 refined xen iron, 1 harvested crystal, and 1 harvested crystal fragment.",
	Materials = {
		xen_iron_refined = 2,
		crystal_harvested = 1,
		crystal_fragment = 1
	},
	Type = 3,
	Category = "Prototype Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_egon" )
		end
}

CraftingTable["weapon_flechettegrenade"] = {
	Name = "Flechette Grenade",
	Description = "Requires 2 refined xen iron and 2 harvested crystal fragments.",
	Materials = {
		xen_iron_refined = 2,
		crystal_fragment = 2
	},
	Type = 3,
	Category = "Prototype Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_flechettegrenade" )
		end
}

CraftingTable["weapon_freezinggun"] = {
	Name = "Freezing Gun",
	Description = "Requires 2 refined xen iron, 2 xen iron, 1 harvested crystal, and 2 harvested crystal fragments.",
	Materials = {
		xen_iron_refined = 2,
		crystal_fragment = 2,
		xen_iron = 2,
		crystal_harvested = 1
	},
	Type = 3,
	Category = "Unusual Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_freezinggun" )
		end
}

CraftingTable["weapon_gauss"] = {
	Name = "Gauss Cannon",
	Description = "Requires 2 refined xen iron, 2 xen iron, 2 harvested crystals, and 3 harvested crystal fragments.",
	Materials = {
		xen_iron_refined = 2,
		crystal_fragment = 3,
		xen_iron = 2,
		crystal_harvested = 2
	},
	Type = 3,
	Category = "Prototype Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_gauss" )
		end
}

CraftingTable["weapon_knife"] = {
	Name = "Knife",
	Description = "Requires 2 xen iron.",
	Materials = {
		xen_iron = 2
	},
	Type = 3,
	Category = "Normal Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_knife" )
		end
}

CraftingTable["weapon_penguin"] = {
	Name = "Penguin",
	Description = "Requires 2 organic matter, 1 rare organic matter, 2 xen iron, 1 refined xen iron, 1 harvested crystal, and 1 harvested crystal fragment.",
	Materials = {
		organic_matter = 2,
		organic_matter_rare = 1,
		xen_iron = 2,
		xen_iron_refined = 1,
		crystal_harvested = 1,
		crystal_fragment = 1
	},
	Type = 3,
	Category = "Unusual Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_penguin" )
		end
}

CraftingTable["weapon_rpg_hl"] = {
	Name = "RPG",
	Description = "Requires 4 refined xen iron, 2 xen iron, and 1 harvested crystal.",
	Materials = {
		xen_iron_refined = 4,
		xen_iron = 2,
		crystal_harvested = 1
	},
	Type = 3,
	Category = "Normal Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_rpg_hl" )
		end
}

CraftingTable["weapon_tripmine"] = {
	Name = "Tripmine",
	Description = "Requires 3 refined xen iron, 1 xen iron, and 2 harvested crystal fragments.",
	Materials = {
		xen_iron_refined = 3,
		xen_iron = 1,
		crystal_fragment = 2
	},
	Type = 3,
	Category = "Normal Weapons",
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_tripmine" )
		end
}

--Combine crafting items

CraftingTable["ent_jack_turret_plinker"] = {
	Name = ".22 LR Sentry",
	Description = "Requires 2 iron and 2 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 2
	},
	Type = 4,
	Category = "Turrets",
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_plinker")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_turret_pistol"] = {
	Name = "9mm Pistol Sentry",
	Description = "Requires 2 iron and 3 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 3
	},
	Type = 4,
	Category = "Turrets",
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_pistol")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_turret_rifle"] = {
	Name = "5.56 Rifle Sentry",
	Description = "Requires 3 iron and 4 wrenches.",
	Materials = {
		ironbar = 3,
		wrench = 4
	},
	Type = 4,
	Category = "Turrets",
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_rifle")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_turret_smg"] = {
	Name = "9mm SMG Sentry",
	Description = "Requires 2 iron and 4 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 4
	},
	Type = 4,
	Category = "Turrets",
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_smg")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_turret_sniper"] = {
	Name = "7.62 Sniper Sentry",
	Description = "Requires 5 iron and 5 wrenches.",
	Materials = {
		ironbar = 5,
		wrench = 5
	},
	Type = 4,
	Category = "Turrets",
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_sniper")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_terminal"] = {
	Name = "Sentry Terminal",
	Description = "Requires 4 iron and 3 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 3
	},
	Type = 4,
	Category = "Turret Tools",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_terminal" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretammobox_9mm"] = {
	Name = "9mm Sentry Ammo",
	Description = "Requires 3 iron.",
	Materials = {
		ironbar = 3
	},
	Type = 4,
	Category = "Turret Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretammobox_9mm" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretammobox_22"] = {
	Name = ".22 LR Sentry Ammo",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 4,
	Category = "Turret Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretammobox_22" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretammobox_556"] = {
	Name = "5.56 Sentry Ammo",
	Description = "Requires 4 iron and 1 wrench.",
	Materials = {
		ironbar = 4,
		wrench = 1
	},
	Type = 4,
	Category = "Turret Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretammobox_556" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretammobox_762"] = {
	Name = "7.62 Sentry Ammo",
	Description = "Requires 4 iron and 3 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 3
	},
	Type = 4,
	Category = "Turret Ammo",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretammobox_762" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretbattery"] = {
	Name = "Sentry Battery",
	Description = "Requires 2 iron and 2 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 2
	},
	Type = 4,
	Category = "Turret Tools",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretbattery" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretrepairkit"] = {
	Name = "Sentry Repair Kit",
	Description = "Requires 4 iron and 4 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 4
	},
	Type = 4,
	Category = "Turret Tools",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretrepairkit" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["locker_key"] = {
	Name = "Combine Science Locker Key",
	Description = "Requires 10 iron.",
	Materials = {
		ironbar = 10
	},
	Type = 4,
	Category = "Other",
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "locker_key" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}