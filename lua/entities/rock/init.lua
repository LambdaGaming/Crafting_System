
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local ent = ents.Create( "rock" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( table.Random( CRAFT_CONFIG_ROCK_MODELS ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	self:SetHealth( CRAFT_CONFIG_ROCK_HEALTH )
	self:SetMaxHealth( CRAFT_CONFIG_ROCK_HEALTH )
	self:SetNWBool( "IsHidden", false )
end

local function UnhideEnt( ent )
	if IsValid( ent ) then
		ent:SetPos( ent:GetPos() + Vector( 0, 0, 500 ) )
		ent:SetMoveType( MOVETYPE_VPHYSICS )
		ent:SetColor( Color( 255, 255, 255, 255 ) )
		ent:SetNWBool( "IsHidden", false )
		ent:SetHealth( ent:GetMaxHealth() )
	end
end

local function HideEnt( ent )
	if IsValid( ent ) then
		ent:SetPos( ent:GetPos() + Vector( 0, 0, -500 ) )
		ent:SetMoveType( MOVETYPE_NONE )
		ent:SetColor( Color( 255, 255, 255, 0 ) )
		ent:SetNWBool( "IsHidden", true )
		timer.Create( "Hidden_"..ent:EntIndex(), CRAFT_CONFIG_MINE_RESPAWN_TIME, 1, function() UnhideEnt( ent ) end )
	end
end

function ENT:OnTakeDamage( dmg )
	local ply = dmg:GetAttacker()
	local wep = ply:GetActiveWeapon()
	local hidden = self:GetNWBool( "IsHidden" )
	if !ply:IsPlayer() then return end
	if self:Health() <= 0 then return end
	if CRAFT_CONFIG_MINE_WHITELIST[string.lower( wep:GetClass() )] then
		local health = self:Health()
		local maxhealth = self:GetMaxHealth()
		self:SetHealth( health - ( maxhealth * 0.05 ) )
	end
	if self:Health() <= 0 and !hidden then
		for i=1, math.random( 2, 6 ) do
			local e = ents.Create( table.Random( CRAFT_CONFIG_ROCK_INGREDIENTS ) )
			e:SetPos( self:GetPos() + Vector( 0, 0, i * 5 ) )
			e:Spawn()
		end
		HideEnt( self )
	end
end
