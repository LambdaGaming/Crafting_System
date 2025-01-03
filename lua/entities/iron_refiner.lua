AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Iron Refiner"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Crafting Table"

function ENT:SpawnFunction( ply, tr, name )
	if not tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_wasteland/laundry_washer001a.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetTrigger( true )
		self:SetUseType( SIMPLE_USE )
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	
	self:SetNWInt( "TotalSmelting", 0 )
end

local ores = {
	["Ruby"] = {
		Time = 150,
		NewEnt = "ruby"
	},
	["Gold"] = {
		Time = 120,
		NewEnt = "goldbar"
	},
	["Diamond"] = {
		Time = 300,
		NewEnt = "diamond"
	}
}

function ENT:Use( ply )
	local found = ents.FindInSphere( self:GetPos(), 400 )
	local foundowned = false
	local total = 0
	for k,v in pairs( found ) do
		if v:GetClass() == "ironbar" and v:GetOwner() == ply then
			total = total + 1
		end
	end
	if total == 0 then
		DarkRP.notify( ply, 1, 6, "No iron detected. Move it closer. If you are trying to smelt something, touch it with the refiner." )
		return
	elseif !ply:canAfford( total * 50 ) then
		DarkRP.notify( ply, 1, 6, "You can't afford to refine this iron! You need at least "..DarkRP.formatMoney( total * 50 ).."." )
		return
	end
	ply:addMoney( -( total * 50 ) )
	for k,v in pairs( found ) do
		if v:GetClass() == "ironbar" and v:GetOwner() == ply then
			v:Remove()
		end
	end
	DarkRP.notify( ply, 0, 6, total.." iron detected. This will cost "..DarkRP.formatMoney( total * 50 ).." and will take "..( total * 60 ).." minutes." )
	timer.Simple( total * 60, function()
		if !IsValid( ply ) then return end
		for i=1,2 do
			local e = ents.Create( "ironbar" )
			e:SetPos( self:GetPos() + Vector( 0, 0, i * 20 ) )
			e:Spawn()
		end
		DarkRP.notify( ply, 0, 6, "Your refined iron is ready." )
	end )
end

function ENT:Touch( ent )
	if self:GetNWInt( "TotalSmelting" ) >= 3 then return end
	local class = ent:GetClass()
	if class == "mgs_ore" then
		local oretype = ent:GetNWString( "type" )
		if ores[oretype] then
			self:SetNWInt( "TotalSmelting", self:GetNWInt( "TotalSmelting" ) + 1 )
			timer.Simple( ores[oretype].Time, function()
				local e = ents.Create( ores[oretype].NewEnt )
				e:SetPos( self:GetPos() + Vector( 0, 0, 50 ) )
				e:Spawn()
				self:EmitSound( "ambient/fire/mtov_flame2.wav" )
				self:SetNWInt( "TotalSmelting", self:GetNWInt( "TotalSmelting" ) - 1 )
			end )
			ent:Remove()
			return
		end
	elseif class == "spawned_weapon" or CraftingTable[class] then
		local finalamount = 0
		local finalclass = ent.GetWeaponClass and ent:GetWeaponClass() or ent:GetClass()
		if !CraftingTable[finalclass] then return end
		local iron = CraftingTable[finalclass].Materials.ironbar
		local wrench = CraftingTable[finalclass].Materials.wrench
		if iron then
			finalamount = finalamount + iron
		end
		if wrench then
			finalamount = finalamount + ( wrench * 2 )
		end
		if !iron and !wrench then
			finalamount = entamount
		end
		self:SetNWInt( "TotalSmelting", self:GetNWInt( "TotalSmelting" ) + 1 )
		timer.Simple( 15 * finalamount, function()
			for i=1, finalamount do
				local e = ents.Create( "ironbar" )
				e:SetPos( self:GetPos() + Vector( 0, 0, i * 20 ) )
				e:Spawn()
			end
			self:EmitSound( "ambient/energy/weld"..math.random( 1, 2 )..".wav" )
			self:SetNWInt( "TotalSmelting", self:GetNWInt( "TotalSmelting" ) - 1 )
		end )
		ent:Remove()
	end
end

if CLIENT then
    function ENT:Draw()
		self:DrawModel()
		local plyShootPos = LocalPlayer():GetShootPos()
		if self:GetPos():DistToSqr( plyShootPos ) < 562500 then
			local pos = self:GetPos()
			pos.z = (pos.z + 15)
			local ang = self:GetAngles()
			
			surface.SetFont("Bebas40Font")
			local title = "Smelter"
			local tw = surface.GetTextSize(title)
			
			ang:RotateAroundAxis(ang:Forward(), 90)
			ang:RotateAroundAxis(ang:Right(), -90)
			local textang = ang
			
			cam.Start3D2D(pos + ang:Right() * -20, ang, 0.2)
				draw.WordBox(2, -tw *0.5 + 5, -180, title, "Bebas40Font", color_theme, color_white)
			cam.End3D2D()
			cam.Start3D2D(pos + ang:Right() * -10, ang, 0.2)
				draw.WordBox(2, -tw *0.5 + -110, -180, "Currently Smelting: "..self:GetNWInt( "TotalSmelting" ).."/3", "Bebas40Font", color_theme, color_white)
			cam.End3D2D()
		end
	end
end
