AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:SetTableType( "hl2" )
	ent:Spawn()
	ent:Activate()
	ply:ChatPrint( "Note: You can change the type by right clicking the entity in the context menu." )
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
	self:SetMaxHealth( tbl.Health or 100 )
	self:SetTrigger( true )
	self:SetMaterial( tbl.Material or "" )
	self.AutomationTimers = {}
    self:PhysWake()
end

util.AddNetworkString( "CraftingTableMenu" )
function ENT:Use( ply )
	local canuse = hook.Run( "UCS_CanUseTable", self, ply )
	if !ply:IsPlayer() or canuse == false then return end
	net.Start( "CraftingTableMenu" )
	net.WriteEntity( self )
	net.WriteEntity( ply )
	net.Send( ply )
end

util.AddNetworkString( "StartCrafting" )
util.AddNetworkString( "CraftMessage" )
local function StartCrafting( len, ply )
	local self = net.ReadEntity()
	local item = net.ReadString()
	local tbl = self:GetData()
	local recipe = CraftingRecipe[item]
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
	if hook.Run( "UCS_CanCraft", self, ply, recipe ) == false then return end
	if recipe.SpawnCheck then
		local check, msg = recipe.SpawnCheck( ply, self )
		if check == false then
			if msg then
				net.Start( "CraftMessage" )
				net.WriteString( msg )
				net.Send( ply )
			end
			return
		end
	end
	if recipe.SpawnOverride then
		local e = recipe.SpawnOverride( ply, self )
		hook.Run( "UCS_OnCrafted", self, ply, recipe, e )
	else
		local e = ents.Create( item )
		e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
		e:Spawn()
		e:Activate()
		self:EmitSound( tbl.CraftSound or "ambient/machines/catapult_throw.wav" )
		hook.Run( "UCS_OnCrafted", self, ply, recipe, e )
	end
	net.Start( "CraftMessage" )
	net.WriteString( "Successfully crafted a "..recipe.Name.."." )
	net.Send( ply )
	for k,v in pairs( recipe.Materials ) do
		self:SetNWInt( "Craft_"..k, self:GetNWInt( "Craft_"..k ) - v )
	end
end
net.Receive( "StartCrafting", StartCrafting )

util.AddNetworkString( "DropItem" )
local function DropItem( len, ply )
	local self = net.ReadEntity()
	local item = net.ReadString()
	local tbl = self:GetData()
	local e = ents.Create( item )
	e:SetPos( self:GetPos() + Vector( 0, 70, 0 ) )
	e:Spawn()
	self:SetNWInt( "Craft_"..item, self:GetNWInt( "Craft_"..item ) - 1 )
	self:EmitSound( tbl.DropSound or "physics/metal/metal_canister_impact_soft1.wav" )
	hook.Run( "UCS_OnDropIngredient", self, ply, e )
end
net.Receive( "DropItem", DropItem )

util.AddNetworkString( "StartAutomate" )
local function StartAutomate( len, ply )
	local self = net.ReadEntity()
	local item = net.ReadString()
	local tbl = self:GetData()
	local recipe = CraftingRecipe[item]
	local timerName = "CraftAutomate"..self:EntIndex()..item
	if !recipe or !recipe.Materials or !recipe.Name then
		error( "Tried to craft using an invalid recipe!" )
	end
	self:SetNWBool( "CraftAutomate"..item, true )
	timer.Create( timerName, tbl.AutomationTime or 120, 0, function()
		if !IsValid( ply ) then
			--Remove timer if player who initiated it left the server
			self:SetNWBool( "CraftAutomate"..item, false )
			timer.Remove( timerName )
			table.RemoveByValue( self.AutomationTimers, timerName )
			return
		end
		for k,v in pairs( recipe.Materials ) do
			if self:GetNWInt( "Craft_"..k ) < v then
				net.Start( "CraftMessage" )
				net.WriteString( "Automation failed. Table is missing ingredients." )
				net.WriteString( tbl.FailSound or "buttons/button2.wav" )
				net.Send( ply )
				return
			end
		end
		if hook.Run( "UCS_CanCraft", self, ply, recipe ) == false then return end
		if recipe.SpawnCheck then
			local check, msg = recipe.SpawnCheck( ply, self )
			if check == false then
				if msg then
					net.Start( "CraftMessage" )
					net.WriteString( msg )
					net.Send( ply )
				end
				return
			end
		end
		if recipe.SpawnOverride then
			local e = recipe.SpawnOverride( ply, self )
			hook.Run( "UCS_OnCrafted", self, ply, recipe, e )
		else
			local e = ents.Create( item )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
			e:Activate()
			self:EmitSound( tbl.CraftSound or "ambient/machines/catapult_throw.wav" )
			hook.Run( "UCS_OnCrafted", self, ply, recipe, e )
		end
		for k,v in pairs( recipe.Materials ) do
			self:SetNWInt( "Craft_"..k, self:GetNWInt( "Craft_"..k ) - v )
		end
	end )
	table.insert( self.AutomationTimers, timerName )
end
net.Receive( "StartAutomate", StartAutomate )

util.AddNetworkString( "StopAutomate" )
local function StopAutomate( len, ply )
	local self = net.ReadEntity()
	local item = net.ReadString()
	local timerName = "CraftAutomate"..self:EntIndex()..item
	self:SetNWBool( "CraftAutomate"..item, false )
	timer.Remove( timerName )
	table.RemoveByValue( self.AutomationTimers, timerName )
end
net.Receive( "StopAutomate", StopAutomate )

function ENT:StartTouch( ent )
	local tbl = self:GetData()
	local typ = self:GetTableType()
	local class = ent:GetClass()
	local ingredient = CraftingIngredient[class]
	if ingredient and ingredient.Types and ingredient.Types[typ] then
		self:SetNWInt( "Craft_"..class, self:GetNWInt( "Craft_"..class ) + 1 )
		self:EmitSound( tbl.PlaceSound or "physics/metal/metal_solid_impact_hard1.wav" )
		local effectdata = EffectData()
		effectdata:SetOrigin( ent:GetPos() )
		effectdata:SetScale( 2 )
		util.Effect( "ManhackSparks", effectdata )
		hook.Run( "UCS_OnAddIngredient", self, ent )
		ent:Remove()
	end
end

function ENT:OnTakeDamage( dmg )
	local damage = dmg:GetDamage()
	self:SetHealth( self:Health() - damage )
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
		else
			self:EmitSound( tbl.DestroySound or "physics/metal/metal_box_break1.wav" )
			self:Remove()
		end
		return
	end
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
