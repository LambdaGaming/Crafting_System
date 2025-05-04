AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:SetTableType( 1 )
	ent:Spawn()
	ent:Activate()
	ply:ChatPrint( "Note: Crafting tables created from the spawn menu will always be set to type 1." )
	return ent
end

function ENT:Initialize()
	local tbl = self:GetData()
	self:SetModel( tbl.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( tbl.Health or 100 )
	self:SetTrigger( true )
	self:SetMaterial( tbl.Material or "" )
	self.AutomationTimers = {}
    self:PhysWake()
	hook.Run( "Craft_OnSpawn", self )
end

util.AddNetworkString( "CraftingTableMenu" )
function ENT:Use( activator, caller )
	local canuse = hook.Run( "Craft_OnUse", self, activator )
	if !activator:IsPlayer() or canuse == false then return end
	net.Start( "CraftingTableMenu" )
	net.WriteEntity( self )
	net.WriteEntity( activator )
	net.Send( activator )
end

util.AddNetworkString( "StartCrafting" )
util.AddNetworkString( "CraftMessage" )
local function StartCrafting( len, ply )
	local self = net.ReadEntity()
	local ent = net.ReadString()
	local tbl = self:GetData()
	local recipe = CraftingRecipe[ent]
	if !recipe or !recipe.Materials or !recipe.Name then
		error( "Tried to craft using an invalid recipe!" )
	end
	for k,v in pairs( recipe.Materials ) do
		if self:GetNWInt( "Craft_"..k ) < v then
			net.Start( "CraftMessage" )
			net.WriteString( "Required items are not on the table!" )
			net.WriteString( tbl.FailSound or "buttons/button2.wav" )
			net.Send( ply )
			return
		end
	end
	if hook.Run( "UCS_CanCraft", ply, self,  ) == false then return end
	if recipe.SpawnOverride then
		local e = recipe.SpawnOverride( ply, self )
		hook.Run( "UCS_OnCrafted", ply, self, ent, e )
	elseif recipe.Entity then
		local e = ents.Create( recipe.Entity )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:Activate()
		self:EmitSound( tbl.CraftSound or "ambient/machines/catapult_throw.wav" )
		hook.Run( "UCS_OnCrafted", ply, self, ent, e )
	elseif recipe.Weapon then
		ply:Give( recipe.Weapon )
		hook.Run( "UCS_OnCrafted", ply, self, ent )
	end
	net.Start( "CraftMessage" )
	net.WriteString( "Successfully crafted a "..recipe.Name.."." )
	net.Send( ply )
	for k,v in pairs( recipe.Materials ) do
		self:SetNWInt( "Craft_"..k, self:GetNWInt( "Craft_"..k ) - v ) --Only removes required materials
	end
end
net.Receive( "StartCrafting", StartCrafting )

util.AddNetworkString( "DropItem" )
local function DropItem( len, ply )
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local tbl = ent:GetData()
	local e = ents.Create( item )
	e:SetPos( ent:GetPos() + Vector( 0, 70, 0 ) )
	e:Spawn()
	ent:SetNWInt( "Craft_"..item, ent:GetNWInt( "Craft_"..item ) - 1 )
	ent:EmitSound( tbl.DropSound or "physics/metal/metal_canister_impact_soft1.wav" )
	hook.Run( "Craft_OnDropItem", ent, ply )
end
net.Receive( "DropItem", DropItem )

util.AddNetworkString( "StartAutomate" )
local function StartAutomate( len, ply )
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local itemname = net.ReadString()
	local timername = "CraftAutomate"..ent:EntIndex()..item
	local tbl = ent:GetData()
	ent:SetNWBool( "CraftAutomate"..item, true )
	timer.Create( timername, tbl.AutomationTime or 120, 0, function()
		local CraftMaterials = CraftingRecipe[item].Materials
		local SpawnItem = CraftingRecipe[item].SpawnFunction
		local SpawnCheck = CraftingRecipe[item].SpawnCheck
		if CraftMaterials then
			for k,v in pairs( CraftMaterials ) do
				if ent:GetNWInt( "Craft_"..k ) < v then
					net.Start( "CraftMessage" )
					net.WriteString( "Automation failed. Table is missing ingredients." )
					net.WriteString( tbl.FailSound or "buttons/button2.wav" )
					net.Send( ply )
					return
				end
			end
			if SpawnCheck and !SpawnCheck( ply, ent ) then return end
			if SpawnItem then
				SpawnItem( ply, ent )
				ent:EmitSound( tbl.CraftSound or "ambient/machines/catapult_throw.wav" )
				net.Start( "CraftMessage" )
				net.WriteString( "Successfully crafted a "..itemname.."." )
				net.Send( ply )
				hook.Run( "Craft_OnStartCrafting", item, ply )
			else
				net.Start( "CraftMessage" )
				net.WriteString( "ERROR! Missing SpawnFunction for "..itemname )
				net.WriteString( tbl.FailSound or "buttons/button2.wav" )
				net.Send( ply )
				return
			end
			for k,v in pairs( CraftMaterials ) do
				ent:SetNWInt( "Craft_"..k, ent:GetNWInt( "Craft_"..k ) - v )
			end
		end
	end )
	table.insert( ent.AutomationTimers, timername )
end
net.Receive( "StartAutomate", StartAutomate )

util.AddNetworkString( "StopAutomate" )
local function StopAutomate( len, ply )
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local timername = "CraftAutomate"..ent:EntIndex()..item
	ent:SetNWBool( "CraftAutomate"..item, false )
	timer.Remove( timername )
	table.RemoveByValue( ent.AutomationTimers, timername )
end
net.Receive( "StopAutomate", StopAutomate )

function ENT:Touch( ent )
	local tbl = self:GetData()
	for k,v in pairs( CraftingIngredient ) do
		if self.TouchCooldown and self.TouchCooldown > CurTime() then return end
		if k == ent:GetClass() then
			self:SetNWInt( "Craft_"..ent:GetClass(), self:GetNWInt( "Craft_"..ent:GetClass() ) + 1 )
			self:EmitSound( tbl.PlaceSound or "physics/metal/metal_solid_impact_hard1.wav" )
			local effectdata = EffectData()
			effectdata:SetOrigin( ent:GetPos() )
			effectdata:SetScale( 2 )
			util.Effect( "ManhackSparks", effectdata )
			ent:Remove()
			hook.Run( "Craft_OnIngredientTouch", self, ent )
			self.TouchCooldown = CurTime() + 0.1 --Small cooldown since ent:Touch runs multiple times before the for loop has time to break
			break
		end
	end
end

function ENT:OnTakeDamage( dmg )
	local candmg = hook.Run( "Craft_OnTakeDamage", self, dmg )
	if candmg == false then return end
	if self:Health() <= 0 and !self.Exploding then
		local tbl = self:GetData()
		if tbl.ShouldExplode then
			self.Exploding = true --Prevents a bunch of fires from spawning at once causing the server to hang for a few seconds if VFire is installed
			local e = ents.Create( "env_explosion" )
			e:SetPos( self:GetPos() )
			e:Spawn()
			e:SetKeyValue( "iMagnitude", 200 )
			e:Fire( "Explode", 0, 0 )
			self:Remove()
			hook.Run( "Craft_OnExplode", self )
		else
			self:EmitSound( tbl.DestroySound or "physics/metal/metal_box_break1.wav" )
			self:Remove()
		end
		return
	end
	local damage = dmg:GetDamage()
	self:SetHealth( self:Health() - damage )
end

function ENT:OnRemove()
	if !self.AutomationTimers then return end
	for _,v in pairs( self.AutomationTimers ) do
		timer.Remove( v )
	end
end

--Example usage in an item spawn function: self:AddItem( "iron", 5 )
--The first argument must be the class name of a registered crafting ingredient
--If you want to remove an item, make the second argument negative
function ENT:AddItem( item, amount )
	self:SetNWInt( "Craft_"..item, math.Clamp( self:GetNWInt( "Craft_"..item ) + amount, 0, math.huge ) )
end

function ENT:GetItemAmount( item )
	return self:GetNWInt( "Craft_"..item )
end
