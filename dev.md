Below is a list of resources developers can use to modify or tap into core functions of the addon.

# Functions
| Name | Scope | Arguments | Returns | Description |
|------|-------|-----------|---------|-------------|
|CraftingTable:AddItem|Server|String `ingredient`, Number `amount`|N/A|Add the specified ingredient to the table. Set amount as negative to subtract.|
|CraftingTable:GetItemAmount|Server|String `ingredient`|Number `amount`|Returns the number of the specified ingredient currently on the table.|
|MineableEntity:Hide|Server|N/A|N/A|Makes the entity invisible and non-solid, and starts a timer to respawn it.|
|MineableEntity:Show|Server|N/A|N/A|Makes the entity visible and solid again, and calls the `UCS_OnMineableRespawned` hook.|

# Hooks
| Name | Scope | Arguments | Returns | Description |
|------|-------|-----------|---------|-------------|
|UCS_CanCraft|Server|Entity `table`, Player `user`, Table `recipe`|Bool `canCraft`|Return false to prevent the player from crafting the specified item.|
|UCS_CanUseTable|Server|Entity `table`, Player `user`|Bool `canUse`|Return false to prevent the player from using the table.|
|UCS_OnCrafted|Server|Entity `table`, Player `user`, Table `recipe`, Entity `craftedItem`|N/A|Called when an item has been successfully crafted.|
|UCS_OnAddIngredient|Server|Entity `table`, Entity `ingredient`|N/A|Called when a crafting ingredient is touched and added to a crafting table.|
|UCS_OnDropIngredient|Server|Entity `table`, Player `user`, Entity `ingredient`|N/A|Called when a crafting ingredient is manually removed from the table.|
|UCS_OnMineableMined|Server|Entity `mineable`, Player `miner`|N/A|Called when a player mines something.|
|UCS_OnMineableRespawned|Server|Entity `mineable`|N/A|Called when a mined entity is respawned.|
