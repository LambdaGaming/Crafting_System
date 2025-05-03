AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:SetMineableType( 1 )
	ent:Spawn()
	ent:Activate()
	ply:ChatPrint( "Note: Mineable entities created from the spawn menu will always be set to type 1." )
	return ent
end

function ENT:Initialize()
	local tbl = self:GetData()
	self:SetModel( table.Random( tbl.Models ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	self:PhysWake()
	self:SetHealth( tbl.Health or 100 )
	self:SetMaxHealth( tbl.Health or 100 )
	self:SetNWBool( "IsHidden", false )
	hook.Run( "Craft_Rock_OnSpawn", self )
end

local function UnhideEnt( ent )
	if IsValid( ent ) then
		ent:SetSolid( SOLID_VPHYSICS )
		ent:SetMoveType( MOVETYPE_VPHYSICS )
		ent:SetColor( color_white )
		ent:SetNWBool( "IsHidden", false )
		ent:SetHealth( ent:GetMaxHealth() )
		local phys = ent:GetPhysicsObject()
		if phys:IsValid() then
			phys:EnableMotion( false )
		end
		hook.Run( "Craft_Rock_OnRespawn", ent )
	end
end

local function HideEnt( ent )
	if IsValid( ent ) then
		local tbl = ent:GetData()
		local color = ent:GetColor()
		ent:SetSolid( SOLID_NONE )
		ent:SetMoveType( MOVETYPE_NONE )
		ent:SetColor( ColorAlpha( color, 0 ) )
		ent:SetNWBool( "IsHidden", true )
		timer.Create( "Hidden_"..ent:EntIndex(), tbl.Respawn or 300, 1, function() UnhideEnt( ent ) end )
	end
end

function ENT:OnTakeDamage( dmg )
	local ply = dmg:GetAttacker()
	if !ply:IsPlayer() or self:Health() <= 0 then return end
	local wep = ply:GetActiveWeapon()
	local hidden = self:GetNWBool( "IsHidden" )
	local wepclass = string.lower( wep:GetClass() )
	local tbl = self:GetData()
	local tool = tbl.Tools[wepclass]
	if tool then
		local health = self:Health()
		local maxhealth = self:GetMaxHealth()
		local damage
		if tool > 0 then
			damage = tool
		else
			damage = dmg:GetDamage()
		end
		self:SetHealth( math.Clamp( health - damage, 0, maxhealth ) )
	end
	if self:Health() <= 0 and !hidden then
		for i=1, math.random( tbl.MinSpawn or 2, tbl.MaxSpawn or 6 ) do
			local shouldspawn = false
			local entspawn
			for k,v in pairs( tbl.Drops ) do
				if math.random( 1, 100 ) < v then
					shouldspawn = true
					entspawn = k
				end
			end
			if shouldspawn then
				local e = ents.Create( entspawn )
				e:SetPos( self:GetPos() + Vector( 0, 0, i * 5 ) )
				e:Spawn()
			end
		end
		HideEnt( self )
		hook.Run( "Craft_Rock_OnMined", self, ply )
	end
end

function ENT:OnRemove()
	local index = self:EntIndex()
	if timer.Exists( "Hidden_"..index ) then
		timer.Remove( "Hidden_"..index )
	end
end
