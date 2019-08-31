
--Customize your crafting table here. I added comments above every constant for people who are inexperienced with Lua

--[[
	NOTE: Some of the table customizations have been moved to ConVars, meaning you can change them through the server console.
	If you wish to have all of the configs in this file and don't want them as ConVars, download the version from the old branch here: https://github.com/LambdaGaming/Crafting_System/tree/old
--]]

--List of models the rocks can have
CRAFT_CONFIG_ROCK_MODELS = {
	"models/props_debris/barricade_short01a.mdl",
	"models/props_debris/barricade_short02a.mdl",
	"models/props_debris/barricade_tall01a.mdl"
}

--List of entities that can be dropped from mining a rock
CRAFT_CONFIG_ROCK_INGREDIENTS = {
	"iron"
}

--Health of the rocks
CRAFT_CONFIG_ROCK_HEALTH = 100

--List of models the trees can have
CRAFT_CONFIG_TREE_MODELS = {
	"models/props_foliage/tree_deciduous_01a-lod.mdl",
	"models/props_foliage/tree_poplar_01.mdl"
}

--List of entities that can be dropped from mining a tree
CRAFT_CONFIG_TREE_INGREDIENTS = {
	"wood"
}

--Health of the trees
CRAFT_CONFIG_TREE_HEALTH = 100

--List of allowed weapons to be used to mine rocks and trees
CRAFT_CONFIG_MINE_WHITELIST = {
	["weapon_crowbar"] = true
}

--How long it takes in seconds for a rock or tree to respawn after it's been mined
CRAFT_CONFIG_MINE_RESPAWN_TIME = 300

--List of entities that are allowed to be placed on the table. Don't forget to configure the items in the shared.lua as well! Failure to do so will result in errors!
CRAFT_CONFIG_ALLOWED_ENTS = {
    ["iron"] = true,
	["wood"] = true
}