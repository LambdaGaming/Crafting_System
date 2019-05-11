
--Customize your crafting table here. I added comments above every constant for people who are inexperienced with Lua

--Health of the table
CRAFT_CONFIG_MAXHEALTH = 100

--Model of the table
CRAFT_CONFIG_MODEL = "models/props_wasteland/controlroom_desk001b.mdl"

--Material of the table, leave as "" if you want to keep the default model texture
CRAFT_CONFIG_MATERIAL = ""

--Color of the table, default is white (which means no change)
CRAFT_CONFIG_COLOR = Color( 255, 255, 255, 255 )

--Sound that plays when an item is placed on the table
CRAFT_CONFIG_PLACE_SOUND = "physics/metal/metal_solid_impact_hard1.wav"

--Sound that plays when an item is being crafted
CRAFT_CONFIG_CRAFT_SOUND = "ambient/machines/catapult_throw.wav"

--Whether or not the table should explode when it's health reaches 0
CRAFT_CONFIG_SHOULD_EXPLODE = true

--Sound that plays when the table is destroyed, only plays when the explosion is disabled, you don't need to have math.random, I only added that for variety
CRAFT_CONFIG_DESTROY_SOUND = "physics/metal/metal_box_break"..math.random( 1, 2 )..".wav"

--Entities that are allowed to be placed on the table. Don't forget to configure the items in the shared.lua as well! Failure to do so will result in errors!
CRAFT_CONFIG_ALLOWED_ENTS = {
    "sent_ball",
	"edit_fog"
}