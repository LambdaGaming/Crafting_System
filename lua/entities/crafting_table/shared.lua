ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crafting Table"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.Category = "Crafting Table"

CraftingTable = {}
CraftingCategory = {}
CraftingIngredient = {}
local COLOR_DEFAULT = Color( 49, 53, 61, 255 )

CraftingIngredient["ironbar"] = {
	Name = "Iron"
}

CraftingIngredient["wrench"] = {
	Name = "Wrench"
}

CraftingIngredient["wood"] = {
	Name = "Wood"
}

CraftingIngredient["dronesrewrite_spy"] = {
	Name = "Spy Drone"
}

CraftingIngredient["goldbar"] = {
	Name = "Gold"
}

CraftingIngredient["ruby"] = {
	Name = "Ruby"
}

CraftingIngredient["diamond"] = {
	Name = "Diamond"
}

CraftingIngredient["electronic"] = {
	Name = "Electronic Component"
}

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
	Name = "Explosives",
	Color = COLOR_DEFAULT
}

CraftingCategory[6] = {
	Name = "Crafting Ingredients",
	Color = COLOR_DEFAULT
}

CraftingCategory[7] = {
	Name = "Tools",
	Color = COLOR_DEFAULT
}

CraftingCategory[8] = {
	Name = "Ammo & Upgrades",
	Color = COLOR_DEFAULT
}

CraftingCategory[9] = {
	Name = "Other",
	Color = COLOR_DEFAULT
}

CraftingTable["arc9_fas_famas"] = {
	Name = "FAMAS",
	Description = "Needs 6 iron and 1 wrench.",
	Category = "Rifles",
	Materials = {
		ironbar = 6,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_famas" )
	end
}

CraftingTable["arc9_fas_mp5"] = {
	Name = "MP5",
	Description = "Needs 4 iron and 1 wrench.",
	Category = "SMGs",
	Materials = {
		ironbar = 4,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_mp5" )
	end
}

CraftingTable["arc9_fas_colt"] = {
	Name = "Colt M639",
	Description = "Needs 4 iron and 1 wrench.",
	Category = "SMGs",
	Materials = {
		ironbar = 4,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_colt" )
	end
}

CraftingTable["arc9_fas_mac11"] = {
	Name = "MAC-11",
	Description = "Needs 3 iron and 1 wrench.",
	Category = "SMGs",
	Materials = {
		ironbar = 3,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_mac11" )
	end
}

CraftingTable["arc9_fas_bizon"] = {
	Name = "PP-19 Bizon",
	Description = "Needs 3 iron and 1 wrench.",
	Category = "SMGs",
	Materials = {
		ironbar = 3,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_bizon" )
	end
}

CraftingTable["arc9_fas_sterling"] = {
	Name = "Sterling L2A3",
	Description = "Needs 5 iron and 1 wrench.",
	Category = "SMGs",
	Materials = {
		ironbar = 5,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_sterling" )
	end
}

CraftingTable["arc9_fas_uzi"] = {
	Name = "Uzi",
	Description = "Needs 4 iron and 1 wrench.",
	Category = "SMGs",
	Materials = {
		ironbar = 4,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_uzi" )
	end
}

CraftingTable["dronesrewrite_cargo"] = {
	Name = "Cargo Drone",
	Description = "Needs 6 iron, 3 wrenches, and 1 electronic component.",
	Category = "Tools",
	Materials = {
		wrench = 3,
		ironbar = 6,
		electronic = 1
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "dronesrewrite_cargo" )
		e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) )
		e:Spawn()
		e:SetupOwner( ply )
	end
}

CraftingTable["dronesrewrite_nanodr"] = {
	Name = "Nano Drone",
	Description = "Needs 5 iron and 3 wrenches.",
	Category = "Tools",
	Materials = {
		wrench = 3,
		ironbar = 5
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "dronesrewrite_nanodr" )
		e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) )
		e:Spawn()
		e:SetupOwner( ply )
	end
}

CraftingTable["dronesrewrite_gunner"] = {
	Name = "Gun Drone",
	Description = "Needs 120 iron, 20 wrenches, and 2 electronic components.",
	Category = "Tools",
	Materials = {
		wrench = 20,
		ironbar = 120,
		electronic = 2
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "dronesrewrite_gunner" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 100 ) )
		e:Spawn()
		e:SetupOwner( ply )
	end
}

CraftingTable["dronesrewrite_plotdr"] = {
	Name = "PLOT-130",
	Description = "Needs 400 iron, 50 wrenches, and 3 electronic components",
	Category = "Tools",
	Materials = {
		wrench = 50,
		ironbar = 400,
		electronic = 3
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "dronesrewrite_plotdr" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 100 ) )
		e:Spawn()
		e:SetupOwner( ply )
	end
}

CraftingTable["dronesrewrite_turret"] = {
	Name = "Controllable Turret",
	Description = "Needs 50 iron, 5 wrenches, and 1 electronic component.",
	Category = "Tools",
	Materials = {
		wrench = 5,
		ironbar = 50,
		electronic = 1
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "dronesrewrite_turret" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 100 ) )
		e:Spawn()
		e:SetupOwner( ply )
	end
}

CraftingTable["arc9_fas_rpk"] = {
	Name = "RPK",
	Description = "Needs 7 iron, 2 wrenches, and 4 wood.",
	Category = "Rifles",
	NeedsBlueprint = true,
	Materials = {
		wrench = 2,
		ironbar = 7,
		wood = 4
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_rpk" )
	end
}

CraftingTable["arc9_fas_m82"] = {
	Name = "Barrett M82",
	Description = "Needs 16 iron",
	Category = "Rifles",
	Materials = {
		ironbar = 16
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m82" )
	end
}

CraftingTable["arc9_fas_ak47"] = {
	Name = "AK-47",
	Description = "Needs 2 wood, 1 wrench, and 7 iron",
	Category = "Rifles",
	Materials = {
		wood = 2,
		ironbar = 7,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_ak47" )
	end
}

CraftingTable["arc9_fas_svd"] = {
	Name = "SVD",
	Description = "Needs 2 wood and 11 iron",
	Category = "Rifles",
	Materials = {
		wood = 2,
		ironbar = 11
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_svd" )
	end
}

CraftingTable["arc9_fas_sks"] = {
	Name = "SKS",
	Description = "Needs 2 wood and 9 iron",
	Category = "Rifles",
	Materials = {
		wood = 2,
		ironbar = 9
	},
	SpawnFunction = function( ply, self )
		ply:Give( "arc9_fas_sks" )
	end
}

CraftingTable["arc9_fas_sr25"] = {
	Name = "SR-25",
	Description = "Needs 9 iron",
	Category = "Rifles",
	Materials = {
		ironbar = 9
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_sr25" )
	end
}

CraftingTable["arc9_fas_m14"] = {
	Name = "M14",
	Description = "Needs 2 wood, 1 wrench, and 9 iron",
	Category = "Rifles",
	Materials = {
		wood = 2,
		ironbar = 9,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m14" )
	end
}

CraftingTable["arc9_fas_m16a2"] = {
	Name = "M16",
	Description = "Needs 1 wrench and 6 iron",
	Category = "Rifles",
	Materials = {
		ironbar = 6,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m16a2" )
	end
}

CraftingTable["arc9_fas_ots33"] = {
	Name = "Ots-33 Pernach",
	Description = "Needs 1 wrench and 4 iron",
	Category = "Pistols",
	Materials = {
		ironbar = 4,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_ots33" )
	end
}

CraftingTable["arc9_fas_rk95"] = {
	Name = "RK-95",
	Description = "Needs 1 wrench and 7 iron",
	Category = "Rifles",
	Materials = {
		ironbar = 7,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_rk95" )
	end
}

CraftingTable["arc9_fas_ak74"] = {
	Name = "AK-74",
	Description = "Needs 1 wrench and 6 iron",
	Category = "Rifles",
	Materials = {
		ironbar = 6,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_ak74" )
	end
}

CraftingTable["arc9_fas_m4a1"] = {
	Name = "M4A1",
	Description = "Needs 6 iron and 1 wrench",
	Category = "Rifles",
	Materials = {
		wrench = 1,
		ironbar = 6
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m4a1" )
	end
}

CraftingTable["arc9_fas_m3super90"] = {
	Name = "M3 Super 90",
	Description = "Needs 4 wrenches and 3 iron",
	Category = "Shotguns",
	Materials = {
		wrench = 4,
		ironbar = 3
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m3super90" )
	end
}

CraftingTable["wrench"] = {
	Name = "Wrench",
	Description = "Needs 2 iron",
	Category = "Crafting Ingredients",
	Materials = {
		ironbar = 2
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "wrench" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["arc9_fas_saiga"] = {
	Name = "Saiga 12K",
	Description = "Needs 5 iron and 4 wrenches",
	Category = "Shotguns",
	Materials = {
		ironbar = 5,
		wrench = 4
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_saiga" )
	end
}

CraftingTable["arc9_fas_g3"] = {
	Name = "G3A3",
	Description = "Needs 9 iron and 1 wrench",
	Category = "Rifles",
	Materials = {
		ironbar = 9,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_g3" )
	end
}

CraftingTable["arc9_fas_g36c"] = {
	Name = "G36C",
	Description = "Needs 6 iron and 1 wrench",
	Category = "Rifles",
	Materials = {
		ironbar = 6,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_g36c" )
	end
}

CraftingTable["arc9_fas_m67"] = {
	Name = "Frag Grenade",
	Description = "Needs 4 iron, 1 diamond, and 1 ruby.",
	NeedsBlueprint = true,
	Category = "Explosives",
	Materials = {
		ironbar = 4,
		diamond = 1,
		ruby = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m67" )
	end
}

CraftingTable["arc9_fas_m24"] = {
	Name = "M24 Sniper",
	Description = "Needs 13 iron",
	Category = "Rifles",
	Materials = {
		ironbar = 13
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m24" )
	end
}

CraftingTable["arc9_fas_sg550"] = {
	Name = "SG550",
	Description = "Needs 6 iron and 1 wrench",
	Category = "Rifles",
	Materials = {
		ironbar = 6,
		wrench = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_sg550" )
	end
}

CraftingTable["sent_turtle"] = {
	Name = "Toy Turtle",
	Description = "Needs 2 wood",
	Category = "Other",
	Materials = {
		wood = 2
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "sent_turtle" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["lockpick"] = {
	Name = "Lockpick",
	Description = "Needs 3 iron",
	Category = "Tools",
	Materials = {
		ironbar = 3
	},
	SpawnFunction = function( ply )
		ply:Give( "lockpick" )
	end
}

CraftingTable["factory_lockpick"] = {
	Name = "Premium Lockpick",
	Description = "Needs 20 iron",
	Category = "Tools",
	Materials = {
		ironbar = 20
	},
	SpawnFunction = function( ply )
		ply:Give( "factory_lockpick" )
	end
}

CraftingTable["usm_c4"] = {
	Name = "Timed C4",
	Description = "Needs 8 iron, 1 gold, and 1 diamond.",
	NeedsBlueprint = true,
	Category = "Explosives",
	Materials = {
		ironbar = 8,
		goldbar = 1,
		diamond = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "usm_c4" )
	end
}

CraftingTable["arc9_fas_ragingbull"] = {
	Name = "Raging Bull",
	Description = "Needs 14 iron",
	Category = "Pistols",
	Materials = {
		ironbar = 14
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_ragingbull" )
	end
}

CraftingTable["arc9_fas_deagle"] = {
	Name = "Desert Eagle",
	Description = "Needs 11 iron",
	Category = "Pistols",
	Materials = {
		ironbar = 11
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_deagle" )
	end
}

CraftingTable["item_box_buckshot"] = {
	Name = "Shotgun Ammo",
	Description = "Needs 1 wrench and 4 iron",
	Category = "Ammo & Upgrades",
	Materials = {
		ironbar = 4,
		wrench = 1
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "item_box_buckshot" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["arc9_fas_870"] = {
	Name = "Remington 870",
	Description = "Needs 3 iron and 3 wrenches",
	Category = "Shotguns",
	Materials = {
		wrench = 3,
		ironbar = 3
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_870" )
	end
}

CraftingTable["arc9_fas_ks23"] = {
	Name = "KS-23",
	Description = "Needs 2 wood, 3 wrenches, and 4 iron",
	Category = "Shotguns",
	Materials = {
		wrench = 3,
		ironbar = 4,
		wood = 2
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_ks23" )
	end
}

CraftingTable["arc9_fas_m249"] = {
	Name = "M429",
	Description = "Needs 2 wrenches and 6 iron",
	NeedsBlueprint = true,
	Category = "Rifles",
	Materials = {
		wrench = 2,
		ironbar = 6
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m249" )
	end
}

CraftingTable["arc9_fas_mc51"] = {
	Name = "MC51B Vollmer",
	Description = "Needs 2 wrenches and 7 iron",
	NeedsBlueprint = true,
	Category = "Rifles",
	Materials = {
		wrench = 2,
		ironbar = 7
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_mc51" )
	end
}

CraftingTable["arc9_fas_m60"] = {
	Name = "M60",
	Description = "Needs 2 wrenches and 7 iron",
	NeedsBlueprint = true,
	Category = "Rifles",
	Materials = {
		wrench = 2,
		ironbar = 7
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m60" )
	end
}

CraftingTable["weapon_slam"] = {
	Name = "SLAM Remote Explosive",
	Description = "Needs 10 iron, 1 gold, and 1 diamond.",
	NeedsBlueprint = true,
	Category = "Explosives",
	Materials = {
		ironbar = 10,
		goldbar = 1,
		diamond = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "weapon_slam" )
	end
}

CraftingTable["weapon_car_bomb"] = {
	Name = "Car Bomb",
	Description = "Needs 6 iron, 1 gold, and 1 diamond.",
	NeedsBlueprint = true,
	Category = "Explosives",
	Materials = {
		ironbar = 6,
		goldbar = 1,
		diamond = 1
	},
	SpawnFunction = function( ply )
		ply:Give( "weapon_car_bomb" )
	end
}

CraftingTable["arc9_fas_m79"] = {
	Name = "M79 Grenade Launcher",
	Description = "Needs 15 iron, 3 diamonds, 2 rubys, and 8 wood",
	NeedsBlueprint = true,
	Category = "Explosives",
	Materials = {
		ironbar = 15,
		diamond = 3,
		ruby = 2,
		wood = 8,
	},
	SpawnFunction = function( ply )
		ply:Give( "arc9_fas_m79" )
	end
}

CraftingTable["rtx4090"] = {
	Name = "RTX 4090",
	Description = "Needs 4 iron, 4 gold, 1 diamond, and 1 electronic component.",
	NeedsBlueprint = true,
	Category = "Explosives",
	Materials = {
		ironbar = 4,
		goldbar = 4,
		diamond = 1,
		electronic = 1
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "rtx4090" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}

CraftingTable["rock_decimator"] = {
	Name = "Rock Decimator",
	Description = "Needs 10 iron and 2 wrenches.",
	Category = "Tools",
	Materials = {
		ironbar = 10,
		wrench = 2
	},
	SpawnFunction = function( ply )
		ply:Give( "rock_decimator" )
	end
}

CraftingTable["police_scanner"] = {
	Name = "Police Scanner",
	Description = "Needs 8 iron and 1 electronic component.",
	Category = "Tools",
	Materials = {
		ironbar = 8,
		electronic = 1
	},
	SpawnFunction = function( ply, self )
		local e = ents.Create( "police_scanner" )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
	end
}
