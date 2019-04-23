
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 2
	local ent = ents.Create( "crafting_table" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    	self:SetModel( CRAFT_CONFIG_MODEL )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( CRAFT_CONFIG_MAXHEALTH )
	self:SetMaxHealth( CRAFT_CONFIG_MAXHEALTH )
	self:SetTrigger( true )
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
	if !caller:IsPlayer() then return end
	net.Start( "CraftingTableMenu" )
	net.WriteEntity( self )
	net.Send( caller )
end

util.AddNetworkString( "StartCrafting" )
net.Receive( "StartCrafting", function( len, ply )
	local self = net.ReadEntity()
	self:EmitSound( "ambient/machines/catapult_throw.wav" )
	
end )

function ENT:StartTouch( ent )
	if table.HasValue( CRAFT_CONFIG_ALLOWED_ENTS, ent:GetClass() ) then
		table.insert( self.CraftingItems, tostring( ent:GetClass() ) )
		self:EmitSound( "physics/metal/metal_solid_impact_hard1.wav" )
		ent:Remove()
	end
end

function ENT:OnRemove()
	
end

function ENT:OnTakeDamage( dmg )
	if self:Health() <= 0 then
		local e = ents.Create( "env_explosion" )
		e:SetPos( pos )
		e:Spawn()
		e:SetKeyValue( "iMagnitude", mag )
		e:Fire( "Explode", 0, 0 )
		self:Remove()
		return
	end
	local damage = dmg:GetDamage()
	self:SetHealth( self:Health() - damage )
end
