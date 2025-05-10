# Universal Crafting System
This is a simple but highly customizable crafting and mining system made to work with all gamemodes. Please note that this addon requires custom Lua scripting for it to be used to it's full potential. It only comes with a basic configuration by default. See the FAQ for more info.

The workshop version can be found [here.](https://steamcommunity.com/sharedfiles/filedetails/?id=1793133869) If you're looking for the old version of the addon, it can be found [here.](https://github.com/LambdaGaming/Crafting_System/releases/tag/v1.20.3)

# Features
## Crafting Table
- A virtually infinite amount of configurations can be created through the ucs_config.lua file.
- Default configuration for crafting HL2 weapons.
- Accepts any entity as an ingredient or craftable item.
- Ingredients and recipes can be configured to only show up in specific table configurations.
- Menu that shows a list of craftable items and ingredients that are currently on the table.
- Ingredients that are added to the table can be manually removed through the menu.
- Table will only take away required ingredients when crafting, leftovers will be kept on the table.
- Automation option that allows users to tell the table to repeatedly craft a certain item as long as it has enough ingredients.
## Mineable Entity
- A virtually infinite amount of configurations can be created through the ucs_config.lua file.
- Default configuration for a rock and tree that can be mined with a crowbar to obtain crafting ingredients.
- 3D2D text that shows the type and health of the entity.
- Once the entity is mined, it will drop a certain amount of specified entities, and will respawn after a certain amount of time. All of these parameters are defined in the ucs_config.lua file.
## Other Features
- Iron and wood ingredient entities
- Built-in persistence system to save crafting tables and mineable entities to the map, accessible by holding C and right clicking them. (Normal persistence systems won't work due to the nature of the entities.)
- You can also change the type of crafting table or mineable entity through the same menu.
- [Developer functions and hooks](dev.md)

# FAQs
## How do I craft an item?
Press your use key on the table, click the View Recipes button in the menu, and click on the item you want to craft. A message will appear telling you what ingredients that item requires. To add ingredients, touch an ingredient entity with the table. Note that the ingredient has to be configured to be compatible with that type of table, or else touching it with the table won't do anything. Once you have enough ingredients, go back into the table menu, select the desired item again, and press the craft button. The crafted entity will spawn below the table, unless it's been configured to spawn elsewhere.

## How do I create new crafting tables, mineable entities, recipes, ingredients, etc?
Read through the [ucs_config.lua file](lua/autorun/ucs_config.lua). It tells you everything you need to know and gives examples.

# Issues & Pull Requests
 If you would like to contribute to this repository by creating an issue or pull request, please refer to the [contributing guidelines.](https://lambdagaming.github.io/contributing.html)
