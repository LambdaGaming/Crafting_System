AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( table.Random( CRAFT_CONFIG_TREE_MODELS ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetHealth( CRAFT_CONFIG_TREE_HEALTH )
	self:SetMaxHealth( CRAFT_CONFIG_TREE_HEALTH )
	self:SetNWBool( "IsHidden", false )
	hook.Run( "Craft_Tree_OnSpawn", self )
end

function ENT:Unhide()
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor( color_white )
	self:SetNWBool( "IsHidden", false )
	self:SetHealth( self:GetMaxHealth() )
	hook.Run( "Craft_Tree_OnRespawn", self )
end

function ENT:Hide()
	local color = self:GetColor()
	self:SetSolid( SOLID_NONE )
	self:SetColor( ColorAlpha( color, 0 ) )
	self:SetNWBool( "IsHidden", true )
	timer.Create( "Hidden_"..self:EntIndex(), CRAFT_CONFIG_TREE_RESPAWN, 1, function()
		if IsValid( self ) then
			self:Unhide()
		end
	end )
end

function ENT:OnTakeDamage( dmg )
	local ply = dmg:GetAttacker()
	if !ply:IsPlayer() or self:Health() <= 0 then return end
	local wep = ply:GetActiveWeapon()
	local hidden = self:GetNWBool( "IsHidden" )
	local wepclass = string.lower( wep:GetClass() )
	if CRAFT_CONFIG_MINE_WHITELIST_TREE[wepclass] then
		local health = self:Health()
		local maxhealth = self:GetMaxHealth()
		self:SetHealth( math.Clamp( health - dmg:GetDamage(), 0, maxhealth ) )
	end
	if self:Health() <= 0 and !hidden then
		for i=1, math.random( CRAFT_CONFIG_MIN_SPAWN, CRAFT_CONFIG_MAX_SPAWN ) do
			local e = ents.Create( "wood" )
			e:SetPos( self:GetPos() + Vector( 0, 0, i * 50 ) )
			e:Spawn()
		end
		self:Hide()
		hook.Run( "Craft_Tree_OnMined", self, ply )
	end
end

function ENT:OnRemove()
	local index = self:EntIndex()
	if timer.Exists( "Hidden_"..index ) then
		timer.Remove( "Hidden_"..index )
	end
end
