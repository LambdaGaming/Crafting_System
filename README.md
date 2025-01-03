# Universal Crafting System
This is a simple, yet highly customizable crafting table made to work with all gamemodes. The workshop version can be found [here.](https://steamcommunity.com/sharedfiles/filedetails/?id=1793133869)

# Features
- Not hard coded to accept specific entities like other crafting systems.
- Accepts any entity as an ingredient and/or craftable item. (As long as the item is configured correctly.)
- Allows for an infinite amount of new items to be added.
- Button that allows players to manually remove ingredients from the table.
- Extra ingredients leftover after crafting an item stay in the table for another use.
- Customizable sounds, UI colors, table appearance, table health, and item spawn function. Some elements such as sounds, table appearance, and table health can be customized in-game as long as you're a superadmin.
- Comes with HL2 and DarkRP weapon support by default.
- Comes with rock and tree entities that players can mine with a crowbar to obtain crafting ingredients.
- Category support for large amounts of items.
- Icons next to each recipe to let the player know if it's able to be crafted, close to having enough materials to be crafted, or can't be crafted.
- Developer functions to help addon and server developers integrate their own systems with this one. You can find more info about that [here.](https://github.com/LambdaGaming/Crafting_System/blob/master/dev.md)
- Automation option that allows users to tell the table to repeatedly craft a certain item as long as it has enough ingredients.

# Other Versions
I've made other versions of this addon with special features for specific servers. If you're looking for a specific feature that this version doesn't have, one of these versions might have it. Please note that I do not give any support for these versions.
- [Blueprint Version](https://github.com/LambdaGaming/Crafting_System/tree/cityrp) - Requires players to place a blueprint of the specified crafting item near the table before being able to craft said item. Items can also be configured to not require a blueprint so it can be crafted like normal.
- [Table Type Version](https://github.com/LambdaGaming/Crafting_System/tree/hlurp) - Allows developers to make more than one table with different items. Useful if you want a separate item list for different teams.

# FAQs
## How do I craft an item?
Simply touch the required ingredients with the table and it will accept it. After all of the required items are in the table, click the craft items button and select the item you want to craft, then press the craft button and your item will spawn below the table.

## How do I create new items or customize the table?
To create new items, download or clone this repository, go to `lua/entities/crafting_table`, open the shared.lua file, and follow the instructions from there. To customize the table, go to `lua/autorun`, open the craft_config.lua file, and follow the instructions from there. Please note that the workshop version does not support custom items and only supports a handful of table customization options in-game.

## Why do rocks/trees spawn invisible after a map change?
This can happen when you save rocks or trees with a perma prop system that saves an entity's color data. If the server shuts down or changes levels while a rock or tree is in it's "mined" state, the entity can become permanently stuck like that. You can prevent this by using a more simplistic perma-prop system that doesn't save this data, or by writing a script that spawns rocks/trees at hard-coded coordinates.
It's also possible for this to happen if you set a custom model for rocks/trees that is either invalid or corrupted.

## Will you help me with [thing I want to do]?
If you are having issues changing values in the config or creating new items, I will guide you through the process. I will NOT generate whole configs for you, or help you make a customized version of the addon to suit your needs. If you want a more advanced level of customization that exceeds what is possible with the default configs, you will have to do it yourself.

# Issues & Pull Requests
 If you would like to contribute to this repository by creating an issue or pull request, please refer to the [contributing guidelines.](https://lambdagaming.github.io/contributing.html)
