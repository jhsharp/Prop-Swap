/// @description 

// Default Settings
if  ((id != oPlayer.linkStart || oPlayer.linkEnd == noone) && id != oPlayer.linkEnd) 
{
	image_angle = defaultAngle;
	turretInvert = defaultTurretInvert;
	shotRate = defaultShotRate;
	bulletSpeed = defaultBulletSpeed;
}

// Box
if (type == "box")
{
	// Update Status
	pushable = true;
	sprite_index = sBox;
}

// Spikes
if (type == "spikes") 
{
	// Update Status
	pushable = false;
	sprite_index = sSpikes;
	
	// Kill Player
	if (place_meeting(x+1, y, oPlayer) || place_meeting(x-1, y, oPlayer) || place_meeting(x, y+1, oPlayer) || place_meeting(x, y-1, oPlayer))
	{
		if (!audio_is_playing(snDeath)) audio_play_sound(snDeath, 150, false);
		SlideTransition(TRANS_MODE.RESTART);
	}
}

// Key
if (type == "key") 
{
	// Update Status
	pushable = true;
	sprite_index = sKey;
	
	// Pick Up
	if (place_meeting(x+1, y, oPlayer) || place_meeting(x-1, y, oPlayer) || place_meeting(x, y+1, oPlayer) || place_meeting(x, y-1, oPlayer))
	{
		audio_play_sound(snKey, 100, false);
		oPlayer.keys++;
		if (id == oPlayer.linkStart)
		{
			if (oPlayer.linkEnd != noone)
			{
				oPlayer.linkEnd.type = oPlayer.linkEnd.defaultType;
				oPlayer.linkEnd = noone;
			}
			oPlayer.linkStart = noone;
		}
		else if (id == oPlayer.linkEnd)
		{
			oPlayer.linkStart.type = oPlayer.linkStart.defaultType;
			oPlayer.linkStart = noone;
			oPlayer.linkEnd = noone;
		}
		instance_destroy(self);
	}
}

// Turret
if (type == "turret")
{
	// Update Status
	pushable = false;
	if (turretInvert) sprite_index = sTurretInvert;
	else sprite_index = sTurret;
	
	// Shoot
	if (shotCooldown == 0)
	{
		audio_play_sound(snShot, 5, false);
		shotCooldown = shotRate;
		newBullet = instance_create_layer(x, y, "Bullet", oBullet);
		newBullet.speed = bulletSpeed;
		if (turretInvert) newBullet.direction = image_angle + 180;
		else newBullet.direction = image_angle;
		newBullet.image_angle = newBullet.direction;
		/*newBullet.cooldown = 30 / bulletSpeed;*/
	}
	else shotCooldown -= 1;
}

// Saw
if (type == "saw")
{
	// Update Status
	pushable = false;
	sprite_index = sSaw;
	if (sawDirection = 0) sawDirection = sawStart;
	
	
	
	// Move
	if (!inAir)
	{
		if place_meeting(x + (sawSpeed * sawDirection), y, oSolid)
		{
			sawMove = sawSpeed;
			while (!place_meeting(x + sawDirection, y, oSolid) && sawMove > 0)
			{
				x += sawDirection;
				sawMove -= 1;
			}
			sawDirection *= -1;
			sawStart = sawDirection;
			x += (sawMove * sawDirection);
			if (!audio_is_playing(snLandingObject)) audio_play_sound(snLandingObject, 1, false);
		}
		else x += sawSpeed * sawDirection;
		image_speed = sawDirection;
	}
	
	// Kill Player
	if (place_meeting(x+3, y, oPlayer) || place_meeting(x-3, y, oPlayer) || place_meeting(x, y+3, oPlayer) || place_meeting(x, y-3, oPlayer))
	{
		if (!audio_is_playing(snDeath)) audio_play_sound(snDeath, 150, false);
		SlideTransition(TRANS_MODE.RESTART);
	}
}
else sawDirection = 0;

// Vertical Movement
if ((type != "turret") || !place_meeting(x + lengthdir_x(1, image_angle - 90), y + lengthdir_y(1, image_angle - 90), oSolid))
	if (place_meeting(x, y + 1, oSolid))
	{
		if (inAir)
		{
			inAir = false;
			audio_play_sound(snLandingObject, 2, false);
		}
		vertSpeed = 0;
	}
	else
	{
		inAir = true;
		if (vertSpeed + grav <= maxFall)
		{
			vertSpeed += grav;
		}
		else vertSpeed = maxFall;
		if (!place_meeting(x, y + vertSpeed, oSolid))
		{
			y += vertSpeed;
		}
		else
		{
			while (!place_meeting(x, y + 1, oSolid))
			{
				y++;
			}
		}
	}

// Collisions
if (place_meeting(x, y, oSolid))
{
	i = 1;
	while (i <= 16)
	{
		if (!place_meeting(x+i, y, oSolid))
		{
			x += i;
			i = 100;
		}
		else if (!place_meeting(x-i, y, oSolid))
		{
			x -= i;
			i = 100;
		}
		else if (!place_meeting(x, y+i, oSolid))
		{
			y += i;
			i = 100;
		}
		else if (!place_meeting(x, y-i, oSolid))
		{
			y -= i;
			i = 100;
		}
		i += 1;
	}
}