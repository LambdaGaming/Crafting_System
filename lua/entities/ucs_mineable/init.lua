AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:SetMineableType( "rock" )
	ent:Spawn()
	ent:Activate()
	ply:ChatPrint( "Note: You can change the type by right clicking the entity in the context menu." )
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
end

function ENT:Show()
	self:SetSolid( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetColor( color_white )
	self:SetNWBool( "IsHidden", false )
	self:SetHealth( self:GetMaxHealth() )
	self:DrawShadow( true )
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion( false )
	end
	hook.Run( "UCS_OnMineableRespawned", self )
end

function ENT:Hide()
	local tbl = self:GetData()
	local color = self:GetColor()
	self:SetSolid( SOLID_NONE )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetColor( ColorAlpha( color, 0 ) )
	self:SetNWBool( "IsHidden", true )
	self:DrawShadow( false )
	timer.Create( "Hidden_"..self:EntIndex(), tbl.Respawn or 300, 1, function()
		if IsValid( self ) then self:Show() end
	end )
end

function ENT:OnTakeDamage( dmg )
	local ply = dmg:GetAttacker()
	local hidden = self:GetNWBool( "IsHidden" )
	if !ply:IsPlayer() or self:Health() <= 0 or hidden then return end
	local wep = ply:GetActiveWeapon()
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
	if self:Health() <= 0 then
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
		self:Hide()
		hook.Run( "UCS_OnMineableMined", self, ply )
	end
end

function ENT:OnRemove()
	local index = self:EntIndex()
	if timer.Exists( "Hidden_"..index ) then
		timer.Remove( "Hidden_"..index )
	end
end
