
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
	self:SetColor( CRAFT_CONFIG_COLOR )

	if CRAFT_CONFIG_MATERIAL != "" then
		self:SetMaterial( CRAFT_CONFIG_MATERIAL )
	end
	
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

util.AddNetworkString( "CraftingTableMenu" )
function ENT:Use( activator, caller )
	if !caller:IsPlayer() then return end
	net.Start( "CraftingTableMenu" )
	net.WriteEntity( self )
	net.Send( caller )
end

util.AddNetworkString( "StartCrafting" )
net.Receive( "StartCrafting", function( len, ply )
	local self = net.ReadEntity()
	local ent = net.ReadString()
	local entname = net.ReadString()
	if CraftingTable[ent].Materials then
		for k,v in pairs( CraftingTable[ent].Materials ) do
			if self[k] < v then --Based off an old crafting system from like 2013, may or may not work
				//ply:ChatPrint( "[Crafting Table]: Required items are not on the table!" )
				ply:SendLua( [[chat.AddText( Color( 100, 100, 255 ), "[Crafting Table]: ", Color( 255, 255, 255 ), "Required items are not on the table!" )]] ) --Testing colored text
				return
			end
		end
		self:EmitSound( CRAFT_CONFIG_CRAFT_SOUND )
		local e = ents.Create( ent )
		e:SetPos( self:GetPos() + Vector( 0, 0, -10 ) ) --Negative Z value so the item spawns under the table, prevents items from spawning on the table and getting consumed
		e:Spawn()
		ply:ChatPrint( "[Crafting Table]: Successfully crafted a "..entname.." ." )
		--table.RemoveByValue( self.CraftingItems, "sent_ball" )
		table.Empty( self.CraftingItems ) --Removes everything on the table, temporary until I can figure out how to remove just the required ingredients
	end
end )

function ENT:StartTouch( ent )
	if table.HasValue( CRAFT_CONFIG_ALLOWED_ENTS, ent:GetClass() ) then
		table.insert( self.CraftingItems, tostring( ent:GetClass() ) )
		self:EmitSound( CRAFT_CONFIG_PLACE_SOUND )
		ent:Remove()
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
			self:EmitSound( "physics/metal/metal_box_break"..math.random( 1, 2 )..".wav" )
			self:Remove()
		end
		return
	end
	local damage = dmg:GetDamage()
	self:SetHealth( self:Health() - damage )
end
