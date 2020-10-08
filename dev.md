Below is a list of resources addon and server developers can use to modify or tap into core functions of the addon.

# Functions
| Name | Scope | Arguments | Returns | Description |
|------|-------|-----------|---------|-------------|
|util.IsAllInWorld|shared|Entity `ent`|Boolean `inworld`|Function to see if part of the entity is outside of the world, not just it's origin.|
|CraftingTable:AddItem|server|String `item`, Int `amount`|N/A|Add the specified ingredient to the table. Set amount as negative to subtract.|

# Hooks
| Name | Scope | Arguments | Returns | Description |
|------|-------|-----------|---------|-------------|
|Craft_OnSpawn|server|Crafting Table `ent`|N/A|Gets called when the crafting table first spawns.|
|Craft_OnStartCrafting|server|Crafting Table `ent`, Crafter `ply`|N/A|Gets called when a player starts crafting an item.|
|Craft_OnDropItem|server|Crafting Table `ent`, Activator `ply`|N/A|Gets called when a player successfully drops an item.|
|Craft_OnIngredientTouch|server|Crafting Table `self`, Ingredient `ent`|N/A|Gets called when an ingredient touches the table and gets put into it.|
|Craft_OnTakeDamage|server|Crafting Table `ent`, CTakeDamageInfo `dmg`|Boolean `allowed`|Gets called when the table takes damage. Returns whether or not the table can take damage.|
|Craft_OnExplode|server|Crafting Table `ent`|N/A|Gets called when the table explodes after its health reaches 0.|
|Craft_OnUse|server|Crafting Table `ent`, Activator `activator`|Boolean `allowed`|Gets called when a player presses their use key on the table. Returns whether or not the player can use the table.|
|Craft_Rock_OnSpawn|server|Rock `ent`|N/A|Gets called when the rock first spawns.|
|Craft_Rock_OnMined|server|Rock `ent`, Miner `ply`|N/A|Gets called when a player mines the rock.|
|Craft_Rock_OnRespawn|server|Rock `ent`|N/A|Gets called when the rock respawns.|
|Craft_Tree_OnSpawn|server|Tree `ent`|N/A|Gets called when the tree first spawns.|
|Craft_Tree_OnMined|server|Tree `ent`, Miner `ply`|N/A|Gets called when a player mines the tree.|
|Craft_Tree_OnRespawn|server|Tree `ent`|N/A|Gets called when the tree respawns.|
|Craft_OnMainMenuOpen|client|Crafting Table `ent`|N/A|Gets called when the main crafting menu is drawn.|
|Craft_OnRecipesOpen|client|Crafting Table `ent`, LocalPlayer `ply`|N/A|Gets called when the crafting recipes menu is drawn.|
|Craft_OnIngredientsOpen|client|Crafting Table `ent`|N/A|Gets called when the crafting ingredients menu is drawn.|
|Craft_OnDropItemFail|client|Crafting Table `ent`|N/A|Gets called when an attempt to drop an ingredient from the table fails.|
