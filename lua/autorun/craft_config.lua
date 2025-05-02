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

local version = "2.0.0"
print( "Universal Crafting System v"..version.." by OPGman successfully loaded.\n" )
