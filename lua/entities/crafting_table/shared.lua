ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crafting Table"
ENT.Author = "OPGman"
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
local COLOR_DEFAULT = Color( 49, 53, 61, 255 )

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

CraftingIngredient["locker_key"] = {
	Name = "Science Locker Key",
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

--Rebel categories
CraftingCategory[1] = {
	Name = "Pistols",
	Color = COLOR_DEFAULT,
	Type = 1
}

CraftingCategory[2] = {
	Name = "SMGs",
	Color = COLOR_DEFAULT,
	Type = 1
}

CraftingCategory[3] = {
	Name = "Rifles",
	Color = COLOR_DEFAULT,
	Type = 1
}

CraftingCategory[4] = {
	Name = "Shotguns",
	Color = COLOR_DEFAULT,
	Type = 1
}

CraftingCategory[5] = {
	Name = "Tools",
	Color = COLOR_DEFAULT,
	Type = 1
}

CraftingCategory[6] = {
	Name = "Crafting Ingredients",
	Color = COLOR_DEFAULT,
	Type = 1
}

CraftingCategory[7] = {
	Name = "Ammo",
	Color = COLOR_DEFAULT,
	Type = 1
}

CraftingCategory[8] = {
	Name = "Explosives",
	Color = COLOR_DEFAULT,
	Type = 1
}

CraftingCategory[9] = {
	Name = "Traps",
	Color = COLOR_DEFAULT,
	Type = 1
}

--Biochemist categories
CraftingCategory[10] = {
	Name = "Creatures",
	Color = COLOR_DEFAULT,
	Type = 2
}

CraftingCategory[11] = {
	Name = "Bioweapons",
	Color = COLOR_DEFAULT,
	Type = 2
}

--Weapons engineer categories
CraftingCategory[12] = {
	Name = "Normal Weapons",
	Color = COLOR_DEFAULT,
	Type = 3
}

CraftingCategory[13] = {
	Name = "Prototype Weapons",
	Color = COLOR_DEFAULT,
	Type = 3
}

CraftingCategory[14] = {
	Name = "Unusual Weapons",
	Color = COLOR_DEFAULT,
	Type = 3
}

--Combine categories
CraftingCategory[15] = {
	Name = "Turrets",
	Color = COLOR_DEFAULT,
	Type = 4
}

CraftingCategory[16] = {
	Name = "Turret Ammo",
	Color = COLOR_DEFAULT,
	Type = 4
}

CraftingCategory[17] = {
	Name = "Turret Tools",
	Color = COLOR_DEFAULT,
	Type = 4
}

CraftingCategory[18] = {
	Name = "Other",
	Color = COLOR_DEFAULT,
	Type = 4
}

--Rebel crafting items
CraftingTable["weapon_pistol"] = {
	Name = "Civil Protection Pistol",
	Description = "Requires 3 iron.",
	Materials = {
		ironbar = 3
	},
	Type = 1,
	Category = "Pistols",
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "item_ammo_pistol" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "item_ammo_smg1" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "item_box_buckshot" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "item_ammo_crossbow" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "item_ammo_ar2" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "bp_sniper_ammo" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "rebel_teleporter" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "two_way_teleporter" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "bouncingmine" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "springgun" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "tripwireextender" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["code_decrypter"] = {
	Name = "Detonation Code Decrypter",
	Description = "Requires 5 iron and a science locker key.",
	Materials = {
		ironbar = 5,
		locker_key = 1
	},
	Type = 1,
	Category = "Tools",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "code_decrypter" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

if game.GetMap() == "rp_mezs" then
	CraftingTable["ent_jack_sleepinbag_rebel"] = {
		Name = "Sleeping Bag",
		Description = "Requires 2 iron and 4 wood.",
		Materials = {
			ironbar = 2,
			wood = 4
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_jack_sleepinbag" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
		end
	}

	CraftingTable["ent_jack_gmod_ezadvparts"] = {
		Name = "Advanced Parts Box",
		Description = "Requires 3 iron and 3 wrenches.",
		Materials = {
			ironbar = 3,
			wrench = 3
		},
		Type = 1,
		Category = "Crafting Materials",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_jack_gmod_ezadvparts" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
		end
	}

	CraftingTable["ent_jack_gmod_ezadvtextiles"] = {
		Name = "Advanced Textiles Box",
		Description = "Requires 2 iron and 2 wood.",
		Materials = {
			ironbar = 2,
			wood = 2
		},
		Type = 1,
		Category = "Crafting Materials",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_jack_gmod_ezadvtextiles" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
		end
	}

	CraftingTable["ent_jack_gmod_ezammo"] = {
		Name = "Turret Ammo",
		Description = "Requires 4 iron.",
		Materials = {
			ironbar = 4
		},
		Type = 1,
		Category = "Ammo",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_jack_gmod_ezammo" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
		end
	}

	CraftingTable["ent_jack_gmod_ezbattery"] = {
		Name = "Battery",
		Description = "Requires 3 iron and 1 wrench.",
		Materials = {
			ironbar = 3,
			wrench = 1
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_jack_gmod_ezbattery" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
		end
	}

	CraftingTable["ent_jack_gmod_ezmedsupplies"] = {
		Name = "Medical Supply Box",
		Description = "Requires 2 iron and 3 wood.",
		Materials = {
			ironbar = 2,
			wood = 3
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_jack_gmod_ezmedsupplies" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
		end
	}

	CraftingTable["ent_jack_gmod_ezparts"] = {
		Name = "Parts Box",
		Description = "Requires 2 iron and 2 wrenches.",
		Materials = {
			ironbar = 2,
			wrench = 2
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_jack_gmod_ezparts" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
		end
	}

	CraftingTable["ent_gauto_fuel"] = {
		Name = "Vehicle Fuel",
		Description = "Requires 4 iron and 1 wrench.",
		Materials = {
			ironbar = 4,
			wrench = 1
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_gauto_fuel" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
		end
	}

	CraftingTable["ent_gauto_repair"] = {
		Name = "Vehicle Repair Kit",
		Description = "Requires 2 iron and 3 wrenches.",
		Materials = {
			ironbar = 2,
			wrench = 3
		},
		Type = 1,
		Category = "Tools",
		SpawnFunction = function( ply, self )
			local e = ents.Create( "ent_gauto_repair" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
			e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "npc_headcrab_black" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "npc_headcrab_fast" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_agrunt" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_controller" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["monster_bullsquid"] = {
	Name = "Bullsquid",
	Description = "Requires 4 organic matter and 2 xen iron.",
	Materials = {
		organic_matter = 4,
		xen_iron = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_bullsquid" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["monster_babyheadcrab"] = {
	Name = "Baby Headcrab",
	Description = "Requires 1 organic matter.",
	Materials = {
		organic_matter = 1
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_babyheadcrab" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["monster_hound_eye"] = {
	Name = "Houndeye",
	Description = "Requires 3 organic matter and 2 xen iron.",
	Materials = {
		organic_matter = 3,
		xen_iron = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_hound_eye" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["monster_zombie_scientist"] = {
	Name = "Zombie Scientist",
	Description = "Requires 2 organic matter and 2 xen iron.",
	Materials = {
		organic_matter = 2,
		xen_iron = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_zombie_scientist" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["monster_zombie_barney"] = {
	Name = "Zombie Security Officer",
	Description = "Requires 2 organic matter and 2 xen iron.",
	Materials = {
		organic_matter = 2,
		xen_iron = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_zombie_barney" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["monster_zombie_soldier"] = {
	Name = "Zombie Marine",
	Description = "Requires 2 organic matter and 2 xen iron.",
	Materials = {
		organic_matter = 2,
		xen_iron = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_zombie_soldier" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["monster_alien_snark"] = {
	Name = "Snark",
	Description = "Requires 1 organic matter and 2 xen iron.",
	Materials = {
		organic_matter = 1,
		xen_iron = 2
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_alien_snark" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["monster_alien_slv"] = {
	Name = "Vortigaunt",
	Description = "Requires 4 organic matter and 3 xen iron.",
	Materials = {
		organic_matter = 4,
		xen_iron = 3
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "monster_alien_slv" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_hornetgun" )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_sporelauncher" )
	end
}

CraftingTable["zombie_serum"] = {
	Name = "Zombie Serum",
	Description = "Requires 4 organic matter and 1 rare organic matter.",
	Materials = {
		organic_matter = 4,
		organic_matter_rare = 1
	},
	Type = 2,
	Category = "Creatures",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "zombie_serum" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
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
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_tripmine" )
	end
}

--Combine crafting items
CraftingTable["ent_jack_gmod_ezsentry"] = {
	Name = "Sentry",
	Description = "Requires 4 iron and 2 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 2
	},
	Type = 4,
	Category = "Turrets",
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "ent_jack_gmod_ezsentry" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
		JMod_Owner( spawn, ply )
		spawn:Spawn()
		spawn:Activate()
		spawn:CPPISetOwner( ply )
	end
}

CraftingTable["ent_jack_gmod_ezammo"] = {
	Name = "Turret Ammo",
	Description = "Requires 4 iron.",
	Materials = {
		ironbar = 4
	},
	Type = 4,
	Category = "Turrets",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "ent_jack_gmod_ezammo" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["ent_jack_gmod_ezbattery"] = {
	Name = "Battery",
	Description = "Requires 3 iron and 1 wrench.",
	Materials = {
		ironbar = 3,
		wrench = 1
	},
	Type = 1,
	Category = "Turrets",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "ent_jack_gmod_ezbattery" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}

CraftingTable["ent_jack_gmod_ezparts"] = {
	Name = "Parts Box",
	Description = "Requires 1 iron and 1 wrench.",
	Materials = {
		ironbar = 1,
		wrench = 1
	},
	Type = 4,
	Category = "Turrets",
	SpawnFunction = function( ply, self )
		local e = ents.Create( "ent_jack_gmod_ezparts" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
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
	SpawnFunction = function( ply, self )
		local e = ents.Create( "locker_key" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
		e:Spawn()
		e:CPPISetOwner( ply )
	end
}
