class ST_ShockProj extends ShockProj;

var ST_Mutator STM;
var WeaponSettingsRepl WSettings;

// For ShockProjectileTakeDamage
var float Health;

var PlayerPawn InstigatingPlayer;
var vector ExtrapolationDelta;

simulated final function WeaponSettingsRepl FindWeaponSettings() {
	local WeaponSettingsRepl S;

	foreach AllActors(class'WeaponSettingsRepl', S)
		return S;

	return none;
}

simulated final function WeaponSettingsRepl GetWeaponSettings() {
	if (WSettings != none)
		return WSettings;

	WSettings = FindWeaponSettings();
	return WSettings;
}

simulated function PostBeginPlay() {
	if (Instigator != none && Instigator.Role == ROLE_Authority) {
		ForEach AllActors(Class'ST_Mutator', STM)
			break; // Find master :D

		if (STM.WeaponSettings.ShockProjectileTakeDamage) {
			Health = STM.WeaponSettings.ShockProjectileHealth;
		}
	}
	Super.PostBeginPlay();
}

simulated function PostNetBeginPlay() {
	local PlayerPawn In;
	local ST_ShockRifle SR;

	super.PostNetBeginPlay();

	if (GetWeaponSettings().ShockProjectileCompensatePing) {
		In = PlayerPawn(Instigator);
		if (In != none && Viewport(In.Player) != none)
			InstigatingPlayer = In;

		if (InstigatingPlayer != none) {
			SR = ST_ShockRifle(InstigatingPlayer.Weapon);
			if (SR != none && SR.LocalDummy != none && SR.LocalDummy.bDeleteMe == false)
				SR.LocalDummy.Destroy();
		}
	} else {
		Disable('Tick');
	}
}

simulated event Tick(float Delta) {
	local vector NewXPolDelta;
	super.Tick(Delta);

	if (InstigatingPlayer == none)
		return;

	// Catch up to server
	if (OldLocation == Location)
		MoveSmooth(Velocity * (0.0005 * InstigatingPlayer.PlayerReplicationInfo.Ping));

	// Extrapolate locally to compensate for ping
	NewXPolDelta = (Velocity * (0.0005 * InstigatingPlayer.PlayerReplicationInfo.Ping));
	MoveSmooth(NewXPolDelta - ExtrapolationDelta);
	ExtrapolationDelta = NewXPolDelta;
}

function SuperExplosion() {
	if (STM.WeaponSettings.bEnableEnhancedSplashShockCombo) {
		STM.EnhancedHurtRadius(
			self,
			STM.WeaponSettings.ShockComboDamage,
			STM.WeaponSettings.ShockComboHurtRadius,
			MyDamageType,
			STM.WeaponSettings.ShockComboMomentum * MomentumTransfer * 2,
			Location);
	} else {
		HurtRadius(
			STM.WeaponSettings.ShockComboDamage,
			STM.WeaponSettings.ShockComboHurtRadius,
			MyDamageType,
			STM.WeaponSettings.ShockComboMomentum * MomentumTransfer * 2,
			Location);
	}
	
	Spawn(Class'ut_ComboRing',,'',Location, Instigator.ViewRotation);
	PlaySound(ExploSound,,20.0,,2000,0.6);	
	
	Destroy(); 
}

function Explode(vector HitLocation,vector HitNormal) {
	PlaySound(ImpactSound, SLOT_Misc, 0.5,,, 0.5+FRand());
	if (STM.WeaponSettings.bEnableEnhancedSplashShockProjectile) {
		STM.EnhancedHurtRadius(
			self,
			STM.WeaponSettings.ShockProjectileDamage,
			STM.WeaponSettings.ShockProjectileHurtRadius,
			MyDamageType,
			STM.WeaponSettings.ShockProjectileMomentum * MomentumTransfer,
			Location);
	} else {
		HurtRadius(
			STM.WeaponSettings.ShockProjectileDamage,
			STM.WeaponSettings.ShockProjectileHurtRadius,
			MyDamageType,
			STM.WeaponSettings.ShockProjectileMomentum * MomentumTransfer,
			Location);
	}
	if (STM.WeaponSettings.ShockProjectileDamage > 60)
		Spawn(class'ut_RingExplosion3',,, HitLocation+HitNormal*8,rotator(HitNormal));
	else
		Spawn(class'ut_RingExplosion',,, HitLocation+HitNormal*8,rotator(Velocity));		

	Destroy();
}

function TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, name DamageType) {
	if (STM.WeaponSettings.ShockProjectileTakeDamage == false)
		return;

	if (DamageType == 'Pulsed'|| DamageType == 'Corroded') {
		Health -= Damage;
		if (Health <= 0) {
			Spawn(class'ut_RingExplosion',,, Location + Momentum * 0.1, rotator(Momentum));
			Destroy();
		}
	}
}

defaultproperties {
}
