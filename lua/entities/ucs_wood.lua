AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Wood (Crafting Ingredient)"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Universal Crafting System"

function ENT:Initialize()
    self:SetModel( "models/props_phx/construct/wood/wood_boardx1.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
	end
	self:PhysWake()
end
