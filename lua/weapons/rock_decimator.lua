AddCSLuaFile()

SWEP.PrintName = "Rock Decimator"
SWEP.Category = "Crafting System"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Base = "weapon_base"
SWEP.Author = "Lambda Gaming"
SWEP.Slot = 1
SWEP.ViewModel = "models/weapons/v_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

function SWEP:Deploy()
	self.SpinningUp = false
end

function SWEP:PrimaryAttack()
	if SERVER then
		if !IsFirstTimePredicted() or self.SpinningUp then return end
		local owner = self:GetOwner()
		owner:EmitSound( "ambient/machines/thumper_shutdown1.wav" )
		self.SpinningUp = true
		timer.Simple( 3.5, function()
			if !IsValid( self ) or !IsValid( owner ) then return end
			local tr = owner:GetEyeTrace()
			local ent = tr.Entity
			if !IsValid( ent ) or ent:GetClass() != "rock" then
				DarkRP.notify( owner, 1, 6, "No rock detected." )
				self:EmitSound( "buttons/button18.wav" )
				return
			end
			
			owner:EmitSound( "npc/strider/fire.wav" )
			local ed = EffectData()
			ed:SetOrigin( self:GetPos() + Vector( 0, 0, 15 ) )
			ed:SetAngles( self:GetAngles() )
			util.Effect( "GaussTracer", ed )

			local ed = EffectData()
			ed:SetOrigin( ent:GetPos() )
			ed:SetNormal( vector_up )
			ed:SetScale( 1.3 )
			ed:SetRadius( 67 )
			ed:SetMagnitude( 18 )
			ed:SetDamageType( DMG_PLASMA )
			util.Effect( "m9k_gdcw_cinematicboom", ed )

			ent:Hide()
			ent:SpawnLoot()
			ent:EmitSound( "ambient/explosions/explode_4.wav" )
			self:TakePrimaryAmmo( 1 )
			if self:Clip1() <= 0 then self:Remove() end
			self.SpinningUp = false
		end )
	end
    self:SetNextPrimaryFire( CurTime() + 1 )
end

function SWEP:SecondaryAttack()
end
