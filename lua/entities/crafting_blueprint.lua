AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crafting Blueprint"
ENT.Author = "OPGman"
ENT.Spawnable = false
ENT.AdminOnly = true

BLUEPRINT_TABLE = {
	{ "usm_c4", "Timed C4" },
	{ "weapon_slam", "SLAM Remote Explosive" },
	{ "arc9_fas_m249", "M249" },
	{ "arc9_fas_m60", "M60" },
	{ "arc9_fas_rpk", "RPK" },
	{ "arc9_fas_mc51", "MC51B Vollmer" },
	{ "arc9_fas_m79", "M79 Grenade Launcher" },
	{ "weapon_car_bomb", "Car Bomb" },
	{ "arc9_fas_m67", "Frag Grenade" },
	{ "rtx4090", "RTX 4090" }
}

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:SetupDataTables()
	self:NetworkVar( "String", 0, "EntName" )
	self:NetworkVar( "String", 1, "RealName" )
	self:NetworkVar( "Int", 0, "Uses" )
end

function ENT:Initialize()
    self:SetModel( "models/props_lab/binderblue.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use( caller, activator )
	DarkRP.notify( caller, 0, 6, "Place this near a crafting table to use it." )
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
		local plyShootPos = LocalPlayer():GetShootPos()
		if self:GetPos():DistToSqr( plyShootPos ) < 100000 then
			local Ang = self:GetAngles() + Angle(-90,0,0)

			surface.SetFont("Bebas40Font")
			local title = "Crafting Blueprint"
			local title2 = self:GetRealName()
			local title3 = "Uses left: "..self:GetUses()
			local tw = surface.GetTextSize( title )

			Ang:RotateAroundAxis( Ang:Forward(), 90 )
			Ang:RotateAroundAxis( Ang:Right(), -90 )
		
			cam.Start3D2D( self:GetPos() + ( self:GetUp() * 6 ) + self:GetRight() * -2, Ang, 0.05 )
				draw.WordBox( 2, -tw *0.5 + 5, -60, title, "Bebas40Font", VOTING.Theme.ControlColor, color_white )
				draw.WordBox( 2, -tw *0.5 + 5, -20, title2, "Bebas40Font", VOTING.Theme.ControlColor, color_white )
				draw.WordBox( 2, -tw *0.5 + 5, 20, title3, "Bebas40Font", VOTING.Theme.ControlColor, color_white )
			cam.End3D2D()
		end
    end
end
