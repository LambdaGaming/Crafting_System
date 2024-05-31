--Customize your crafting table here. Each constant has a comment above it to tell you what it does.

--[[
	NOTE: Some of the table customizations have been moved to ConVars, meaning you can change them through the server console or spawn menu.
	Below are the customizations that are configurable through ConVars by default. If you want to configure everything through this file,
	uncomment the lines below.
--]]

--Health of the table
--CRAFT_CONFIG_MAX_HEALTH = 100

--Model of the table
--CRAFT_CONFIG_MODEL = "models/props_wasteland/controlroom_desk001b.mdl"

--Material of the table, leave as an empty string if you want to keep the default model texture
--CRAFT_CONFIG_MATERIAL = ""

--Sound that plays when an item is placed on the table
--CRAFT_CONFIG_PLACE_SOUND = "physics/metal/metal_solid_impact_hard1.wav"

--Sound that plays when an item is crafted
--CRAFT_CONFIG_CRAFT_SOUND = "ambient/machines/catapult_throw.wav"

--Sound that plays when a button is pressed in the menu
--CRAFT_CONFIG_UI_SOUND = "ui/buttonclickrelease.wav"

--Sound that plays when an item is selected
--CRAFT_CONFIG_SELECT_SOUND = "buttons/lightswitch2.wav"

--Sound that plays when crafting fails
--CRAFT_CONFIG_FAIL_SOUND = "buttons/button2.wav"

--Sound that plays when an ingredient is manually removed from the table
--CRAFT_CONFIG_DROP_SOUND = "physics/metal/metal_canister_impact_soft1.wav"

--Sound that plays when the table is destroyed, only plays when the explosion is disabled, you don't need to have math.random, I only added that for variety
--CRAFT_CONFIG_DESTROY_SOUND = "physics/metal/metal_box_break"..math.random( 1, 2 )..".wav"

--Whether or not the table should explode when its health reaches 0
--CRAFT_CONFIG_SHOULD_EXPLODE = true

--Health of the trees
--CRAFT_CONFIG_TREE_HEALTH = 100

--How long in seconds it takes for a tree to respawn
--CRAFT_CONFIG_TREE_RESPAWN = 300

--Minimum number of entities that can be mined from a rock or tree
--CRAFT_CONFIG_MIN_SPAWN = 2

--Maximum number of entities that can be mined from a rock or tree
--CRAFT_CONFIG_MAX_SPAWN = 6

--Health of the rocks
--CRAFT_CONFIG_ROCK_HEALTH = 100

--How long in seconds it takes for a rock to respawn
--CRAFT_CONFIG_ROCK_RESPAWN = 300

--Whether or not players should be allowed to use the automation feature
--CRAFT_CONFIG_ALLOW_AUTOMATION = true

--The time it takes in seconds for the table to complete an automation process
--CRAFT_CONFIG_AUTOMATION_TIME = 120

--Max range in hammer units that the player can be away from the table to get automation messages. Set to 0 for infinite
--CRAFT_CONFIG_AUTOMATION_MESSAGE_RANGE = 0


--[[
	NOTE: Below are all of the customizations that don't have ConVar counterparts. Commenting out these lines will cause errors.
]]

--Color of the table, default is white (which means no change)
CRAFT_CONFIG_COLOR = color_white --Using a global for optimization, you can also use Color()

--Color of the menu background
CRAFT_CONFIG_MENU_COLOR = Color( 49, 53, 61, 200 )

--Color of the buttons
CRAFT_CONFIG_BUTTON_COLOR = Color( 230, 93, 80, 255 )

--Color of the button text if all required ingredients are on the table
CRAFT_CONFIG_BUTTON_TEXT_COLOR = color_white

--List of models the rocks can have
CRAFT_CONFIG_ROCK_MODELS = {
	"models/props_debris/barricade_short01a.mdl",
	"models/props_debris/barricade_short02a.mdl",
	"models/props_debris/barricade_tall01a.mdl"
}

--List of entities that can be dropped from mining a rock
CRAFT_CONFIG_ROCK_INGREDIENTS = {
	{ "iron", 100 } --First entry is the entity name, second entry is the chance it has of spawning from 1 to 100
}

--List of models the trees can have
CRAFT_CONFIG_TREE_MODELS = {
	"models/props_foliage/tree_deciduous_01a-lod.mdl",
	"models/props_foliage/tree_poplar_01.mdl"
}

--List of entities that can be dropped from mining a tree
CRAFT_CONFIG_TREE_INGREDIENTS = {
	{ "wood", 100 }
}

--List of allowed weapons to be used to mine trees
CRAFT_CONFIG_MINE_WHITELIST_TREE = {
	["weapon_crowbar"] = true
}

--Same as above but for rocks
CRAFT_CONFIG_MINE_WHITELIST_ROCK = {
	["weapon_crowbar"] = true
}

--Specify weapons to deal specific damage to rocks and trees. Any weapons listed here must be in one of the whitelists to work.
--Any weapons not listed here but are in the whitelist will assume their default damage values
CRAFT_CONFIG_MINE_DAMAGE_OVERRIDE = {
	["weapon_crowbar"] = 5
}


--Don't touch anything below this line unless you know what you're doing

--Function to see if part of the entity is outside of the world, not just it's origin
--Only accurate on models with simple geometry
function util.IsAllInWorld( ent )
	if IsValid( ent ) and IsEntity( ent ) then
		local inworld = ent:IsInWorld()
		local vec1, vec2 = ent:GetCollisionBounds()
		local realvec1, realvec2 = ent:WorldToLocal( vec1 ), ent:WorldToLocal( vec2 )
		if inworld and util.IsInWorld( realvec1 ) and util.IsInWorld( realvec2 ) then
			return true
		end
	end
	return false
end

local version = "1.20.3"
MsgC( Color( 0, 0, 255 ), "Universal Crafting System v"..version.." by OPGman successfully loaded.\n" )
