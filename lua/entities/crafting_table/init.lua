
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 2
	local ent = ents.Create( name )
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
	self:SetColor( CRAFT_CONFIG_COLOR )

	if CRAFT_CONFIG_MATERIAL != "" then
		self:SetMaterial( CRAFT_CONFIG_MATERIAL )
	end
	
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.gotblueprint = false
end

util.AddNetworkString( "CraftingTableMenu" )
function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return end
	net.Start( "CraftingTableMenu" )
	net.WriteEntity( self )
	net.WriteEntity( activator )
	net.Send( activator )
end

util.AddNetworkString( "StartCrafting" )
util.AddNetworkString( "CraftMessage" )
net.Receive( "StartCrafting", function( len, ply )
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
					surface.PlaySound( CRAFT_CONFIG_FAIL_SOUND )
				]] )
				return
			end
		end
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 120 ) ) do
			if !CraftingTable[ent].NeedsBlueprint then
				self.gotblueprint = true
				break
			end
			if v:GetClass() == "crafting_blueprint" and v:GetEntName() == ent then
				self.gotblueprint = true
				if v:GetUses() == 1 then
					v:Remove()
				else
					v:SetUses( v:GetUses() - 1 )
				end
				break
			end
		end
		if !self.gotblueprint then
			ply:SendLua( [[
				chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", color_white, "Required blueprint not detected!" ) 
				surface.PlaySound( CRAFT_CONFIG_FAIL_SOUND )
			]] )
			return
		else
			self.gotblueprint = false
		end
		if SpawnCheck and !SpawnCheck( ply, self ) then return end
		if SpawnItem then
			local validfunction = true
			SpawnItem( ply, self )
			self:EmitSound( CRAFT_CONFIG_CRAFT_SOUND )
			net.Start( "CraftMessage" )
			net.WriteBool( validfunction )
			net.WriteString( entname )
			net.Send( ply )
		else
			local validfunction = false
			net.Start( "CraftMessage" )
			net.WriteBool( validfunction )
			net.WriteString( entname )
			net.Send( ply )
			return
		end
		local discount = false
		for k,v in pairs( CraftMaterials ) do
			local amount = v
			if ply:Team() == TEAM_GUN then
				if k == "ironbar" and amount >= 4 then
					amount = math.Round( amount / 2 )
				elseif k == "wrench" and amount >= 2 then
					amount = math.Round( amount / 2 )
				end
				discount = true
			end
			self:SetNWInt( "Craft_"..k, self:GetNWInt( "Craft_"..k ) - amount ) --Only removes required materials
		end
		if discount then
			ply:SendLua( [[chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", color_white, "Gun dealer discount applied." )]] )
		end
	end
end )

util.AddNetworkString( "DropItem" )
net.Receive( "DropItem", function( len, ply )
	local ent = net.ReadEntity()
	local item = net.ReadString()
	local e = ents.Create( item )
	e:SetPos( ent:GetPos() + Vector( 0, 70, 0 ) )
	e:Spawn()
	ent:SetNWInt( "Craft_"..item, ent:GetNWInt( "Craft_"..item ) - 1 )
	ent:EmitSound( CRAFT_CONFIG_DROP_SOUND )
end )

function ENT:Touch( ent )
	for k,v in pairs( CraftingIngredient ) do
		if self.TouchCooldown and self.TouchCooldown > CurTime() then return end
		if k == ent:GetClass() then
			self:SetNWInt( "Craft_"..ent:GetClass(), self:GetNWInt( "Craft_"..ent:GetClass() ) + 1 )
			self:EmitSound( CRAFT_CONFIG_PLACE_SOUND )
			local effectdata = EffectData()
			effectdata:SetOrigin( ent:GetPos() )
			effectdata:SetScale( 2 )
			util.Effect( "ManhackSparks", effectdata )
			ent:Remove()
			self.TouchCooldown = CurTime() + 0.1 --Small cooldown since ent:Touch runs multiple times before the for loop has time to break
			break
		end
	end
end

function ENT:OnTakeDamage( dmg )
	if self:Health() <= 0 and !self.Exploding then
		if CRAFT_CONFIG_SHOULD_EXPLODE then
			self.Exploding = true --Prevents a bunch of fires from spawning at once causing the server to hang for a few seconds if VFire is installed
			local e = ents.Create( "env_explosion" )
			e:SetPos( self:GetPos() )
			e:Spawn()
			e:SetKeyValue( "iMagnitude", 200 )
			e:Fire( "Explode", 0, 0 )
			self:Remove()
		else
			self:EmitSound( CRAFT_CONFIG_DESTROY_SOUND )
			self:Remove()
		end
		return
	end
	local damage = dmg:GetDamage()
	self:SetHealth( self:Health() - damage )
end
