AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 50
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( CRAFT_CONFIG_MODEL or GetConVar( "Craft_Config_Model" ):GetString() )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( CRAFT_CONFIG_MAX_HEALTH or GetConVar( "Craft_Config_MaxHealth" ):GetInt() )
	self:SetMaxHealth( CRAFT_CONFIG_MAX_HEALTH or GetConVar( "Craft_Config_MaxHealth" ):GetInt() )
	self:SetTrigger( true )
	self:SetColor( CRAFT_CONFIG_COLOR )
	self:SetMaterial( CRAFT_CONFIG_MATERIAL or GetConVar( "Craft_Config_Material" ):GetString() )

	self.AutomationTimers = {}
	
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
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
	local entname = net.ReadString()
	local CraftMaterials = CraftingTable[ent].Materials
	local SpawnItem = CraftingTable[ent].SpawnFunction
	local SpawnCheck = CraftingTable[ent].SpawnCheck
	if CraftMaterials then
		for k,v in pairs( CraftMaterials ) do
			if self:GetNWInt( "Craft_"..k ) < v then
				ply:SendLua( [[
					chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", color_white, "Required items are not on the table!" ) 
					surface.PlaySound( CRAFT_CONFIG_FAIL_SOUND or GetConVar( "Craft_Config_Fail_Sound" ):GetString() )
				]] )
				return
			end
		end
		if SpawnCheck and !SpawnCheck( ply, self ) then return end
		if SpawnItem then
			local validfunction = true
			SpawnItem( ply, self )
			self:EmitSound( CRAFT_CONFIG_CRAFT_SOUND or GetConVar( "Craft_Config_Craft_Sound" ):GetString() )
			net.Start( "CraftMessage" )
			net.WriteBool( validfunction )
			net.WriteString( entname )
			net.Send( ply )
			hook.Run( "Craft_OnStartCrafting", ent, ply )
		else
			local validfunction = false
			net.Start( "CraftMessage" )
			net.WriteBool( validfunction )
			net.WriteString( entname )
			net.Send( ply )
			return
		end
		for k,v in pairs( CraftMaterials ) do
			self:SetNWInt( "Craft_"..k, self:GetNWInt( "Craft_"..k ) - v ) --Only removes required materials
		end
	end
end
net.Receive( "StartCrafting", StartCrafting )

util.AddNetworkString( "DropItem" )
local function DropItem( len, ply )
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local e = ents.Create( item )
	e:SetPos( ent:GetPos() + Vector( 0, 70, 0 ) )
	e:Spawn()
	ent:SetNWInt( "Craft_"..item, ent:GetNWInt( "Craft_"..item ) - 1 )
	ent:EmitSound( CRAFT_CONFIG_DROP_SOUND or GetConVar( "Craft_Config_Drop_Sound" ):GetString() )
	hook.Run( "Craft_OnDropItem", ent, ply )
end
net.Receive( "DropItem", DropItem )

util.AddNetworkString( "StartAutomate" )
local function StartAutomate( len, ply )
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local itemname = net.ReadString()
	local timername = "CraftAutomate"..ent:EntIndex()..item
	ent:SetNWBool( "CraftAutomate"..item, true )
	timer.Create( timername, CRAFT_CONFIG_AUTOMATION_TIME or GetConVar( "Craft_Config_Automation_Time" ):GetInt(), 0, function()
		local CraftMaterials = CraftingTable[item].Materials
		local SpawnItem = CraftingTable[item].SpawnFunction
		local SpawnCheck = CraftingTable[item].SpawnCheck
		if CraftMaterials then
			local radius = CRAFT_CONFIG_AUTOMATION_MESSAGE_RANGE or GetConVar( "Craft_Config_Automation_Message_Range" ):GetInt()
			local findents = ents.FindInSphere( ent:GetPos(), radius )
			for k,v in pairs( CraftMaterials ) do
				if ent:GetNWInt( "Craft_"..k ) < v then
					for a,b in pairs( findents ) do
						if b == ply or radius == 0 then
							ply:SendLua( [[
								chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", color_white, "Automation failed. Table is missing ingredients." ) 
								surface.PlaySound( CRAFT_CONFIG_FAIL_SOUND or GetConVar( "Craft_Config_Fail_Sound" ):GetString() )
							]] )
							break
						end
					end
					return
				end
			end
			if SpawnCheck and !SpawnCheck( ply, ent ) then return end
			if SpawnItem then
				local validfunction = true
				SpawnItem( ply, ent )
				ent:EmitSound( CRAFT_CONFIG_CRAFT_SOUND or GetConVar( "Craft_Config_Craft_Sound" ):GetString() )
				for k,v in pairs( findents ) do
					if v == ply or radius == 0 then
						net.Start( "CraftMessage" )
						net.WriteBool( validfunction )
						net.WriteString( itemname )
						net.Send( ply )
					end
				end
				hook.Run( "Craft_OnStartCrafting", item, ply )
			else
				local validfunction = false
				for k,v in pairs( findents ) do
					if v == ply or radius == 0 then
						net.Start( "CraftMessage" )
						net.WriteBool( validfunction )
						net.WriteString( itemname )
						net.Send( ply )
					end
				end
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
	for k,v in pairs( CraftingIngredient ) do
		if self.TouchCooldown and self.TouchCooldown > CurTime() then return end
		if k == ent:GetClass() then
			self:SetNWInt( "Craft_"..ent:GetClass(), self:GetNWInt( "Craft_"..ent:GetClass() ) + 1 )
			self:EmitSound( CRAFT_CONFIG_PLACE_SOUND or GetConVar( "Craft_Config_Place_Sound" ):GetString() )
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
		if CRAFT_CONFIG_SHOULD_EXPLODE or GetConVar( "Craft_Config_Should_Explode" ):GetBool() then
			self.Exploding = true --Prevents a bunch of fires from spawning at once causing the server to hang for a few seconds if VFire is installed
			local e = ents.Create( "env_explosion" )
			e:SetPos( self:GetPos() )
			e:Spawn()
			e:SetKeyValue( "iMagnitude", 200 )
			e:Fire( "Explode", 0, 0 )
			self:Remove()
			hook.Run( "Craft_OnExplode", self )
		else
			self:EmitSound( CRAFT_CONFIG_DESTROY_SOUND or GetConVar( "Craft_Config_Destroy_Sound" ):GetString() )
			self:Remove()
		end
		return
	end
	local damage = dmg:GetDamage()
	self:SetHealth( self:Health() - damage )
end

function ENT:OnRemove()
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
