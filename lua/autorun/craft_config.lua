
--Customize your crafting table here. I added comments above every constant for people who are inexperienced with Lua

--[[
	NOTE: Some of the table customizations have been moved to ConVars, meaning you can change them through the server console.
	If you wish to have all of the configs in this file and don't want them as ConVars, download the version from the old branch here: https://github.com/LambdaGaming/Crafting_System/tree/old
--]]

--Color of the table, default is white (which means no change)
CRAFT_CONFIG_COLOR = Color( 255, 255, 255, 255 )

--Color of the menu background
CRAFT_CONFIG_MENU_COLOR = Color( 49, 53, 61, 200 )

--Color of the buttons
CRAFT_CONFIG_BUTTON_COLOR = Color( 230, 93, 80, 255 )

--Color of the button text
CRAFT_CONFIG_BUTTON_TEXT_COLOR = color_white --Using a global for optimization, you can also use Color()

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

--List of models the trees can have
CRAFT_CONFIG_TREE_MODELS = {
	"models/props_foliage/tree_deciduous_01a-lod.mdl",
	"models/props_foliage/tree_poplar_01.mdl"
}

--List of entities that can be dropped from mining a tree
CRAFT_CONFIG_TREE_INGREDIENTS = {
	"wood"
}

--List of allowed weapons to be used to mine rocks and trees
CRAFT_CONFIG_MINE_WHITELIST = {
	["weapon_crowbar"] = true
}