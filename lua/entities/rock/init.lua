AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local ores = {
	["Ruby"] = { color_red, 30, { 7, 15 } },
	["Gold"] = { color_yellow, 60, { 3, 5 } },
	["Diamond"] = { Color( 100, 100, 255 ), 160, { 1, 3 } },
	["Rock"] = { Color( 128, 128, 128 ), 10, { 1, 3 } }
}

function ENT:Initialize()
    self:SetModel( table.Random( CRAFT_CONFIG_ROCK_MODELS ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self:SetNWBool( "IsHidden", false )
	hook.Run( "Craft_Rock_OnSpawn", self )
	self.Loot = {}
	self:CreateLoot()
end

function ENT:Unhide()
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor( color_white )
	self:SetNWBool( "IsHidden", false )
	self:SetHealth( self:GetMaxHealth() )
	self:CreateLoot()
	hook.Run( "Craft_Rock_OnRespawn", self )
end

function ENT:Hide()
	local color = self:GetColor()
	self:SetSolid( SOLID_NONE )
	self:SetColor( ColorAlpha( color, 0 ) )
	self:SetNWBool( "IsHidden", true )
	timer.Create( "Hidden_"..self:EntIndex(), CRAFT_CONFIG_ROCK_RESPAWN, 1, function()
		if IsValid( self ) then
			self:Unhide()
		end
	end )
end

local function GetRandomOre( type )
	local tbl = { "Ruby", "Gold", "Diamond" }
	return tbl[math.random( #tbl )]
end

--[[
	Loot table structure:
	{ EntName, Amount, OreType }
	OR
	{ EntName, Amount }
]]
function ENT:CreateLoot()
	local rand = math.random( 1, 100 )
	if rand >= 60 then
		local rand2 = math.random( 0, 1 )
		table.insert( self.Loot, {"mgs_ore", 2, "Rock" } )
		if rand2 == 1 then
			table.insert( self.Loot, { "ironbar", 2 } )
		else
			table.insert( self.Loot, {"mgs_ore", 2, true } )
		end
	elseif rand >= 30 and rand < 60 then
		local rand2 = math.random( 0, 1 )
		table.insert( self.Loot, {"mgs_ore", 2, "Rock" } )
		if rand2 == 1 then
			table.insert( self.Loot, { "ironbar", 4 } )
		else
			table.insert( self.Loot, {"mgs_ore", 4, true } )
		end
	elseif rand >= 10 and rand < 30 then
		table.insert( self.Loot, { "mgs_ore", 3, true } )
		table.insert( self.Loot, { "ironbar", 3 } )
	elseif rand > 1 and rand < 10 then
		table.insert( self.Loot, { "mgs_ore", 6, true } )
		table.insert( self.Loot, { "ironbar", 6 } )
	else
		table.insert( self.Loot, { "ironbar", 15 } )
	end

	local totaliron = 0
	for k,v in pairs( self.Loot ) do
		if v[1] == "ironbar" then
			totaliron = totaliron + v[2]
		end
	end
	self:SetHealth( 5 + totaliron )
	self:SetMaxHealth( 5 + totaliron )
end

function ENT:SpawnLoot()
	for k,v in pairs( self.Loot ) do
		for i = 1, v[2] do
			local e = ents.Create( v[1] )
			e:SetPos( self:GetPos() + Vector( math.Rand( 1, 20 ), math.Rand( 1, 20 ), 20 ) )
			if v[3] then
				local ore
				if isstring( v[3] ) then
					ore = v[3]
				else
					ore = GetRandomOre()
				end
				e:SetNWInt( "price", ores[ore][2] )
				e:SetNWInt( "mass", math.Rand( ores[ore][3][1], ores[ore][3][2] ) )
				e:SetNWString( "type", ore )
				e:SetColor( ores[ore][1] )
			end
			e:Spawn()
			self.Loot = {}
		end
	end
end

function ENT:OnTakeDamage( dmg )
	local ply = dmg:GetAttacker()
	if !ply:IsPlayer() or self:Health() <= 0 then return end
	local wep = ply:GetActiveWeapon()
	local hidden = self:GetNWBool( "IsHidden" )
	local wepclass = string.lower( wep:GetClass() )
	if CRAFT_CONFIG_MINE_WHITELIST_ROCK[wepclass] then
		local health = self:Health()
		local maxhealth = self:GetMaxHealth()
		self:SetHealth( math.Clamp( health - dmg:GetDamage(), 0, maxhealth ) )
	end
	if self:Health() <= 0 and !hidden then
		self:Hide()
		self:SpawnLoot()
		hook.Run( "Craft_Rock_OnMined", self, ply )
	end
end

function ENT:OnRemove()
	local index = self:EntIndex()
	if timer.Exists( "Hidden_"..index ) then
		timer.Remove( "Hidden_"..index )
	end
end
