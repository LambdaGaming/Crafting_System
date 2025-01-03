AddCSLuaFile()

SWEP.PrintName = "Rock Scanner"
SWEP.Category = "Crafting System"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Base = "weapon_base"
SWEP.Author = "Lambda Gaming"
SWEP.Slot = 1
SWEP.ViewModel = "models/weapons/v_stunbaton.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"

SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

function SWEP:Deploy()
	self.Scanning = false
end

function SWEP:PrimaryAttack()
	if SERVER then
		if !IsFirstTimePredicted() then return end
		local tr = self.Owner:GetEyeTrace().Entity
		if !IsValid( tr ) or tr:GetClass() != "rock" or self.Owner:GetPos():DistToSqr( tr:GetPos() ) > 40000 then
			self:GetOwner():ChatPrint( "No rock detected." )
			self:GetOwner():EmitSound( "buttons/combine_button_locked.wav" )
			return
		end
		self:GetOwner():ChatPrint( "Scanning..." )
		tr:SetMaterial( "models/wireframe" )
		self:GetOwner():EmitSound( "buttons/combine_button2.wav" )
		timer.Simple( 3, function()
			local ores = 0
			local iron = 0
			for k,v in pairs( tr.Loot ) do
				if v[1] == "mgs_ore" then
					ores = ores + v[2]
				else
					iron = iron + v[2]
				end
			end
			self:GetOwner():ChatPrint( "Materials detected: "..ores.." Ores and "..iron.." Iron" )
			self:GetOwner():EmitSound( "buttons/combine_button3.wav" )
			tr:SetMaterial( "" )
		end )
	end
    self:SetNextPrimaryFire( CurTime() + 1 )
end

function SWEP:SecondaryAttack()
end
