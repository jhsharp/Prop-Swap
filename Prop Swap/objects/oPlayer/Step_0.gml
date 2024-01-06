/// @description 

// Input
left = keyboard_check(ord("A"));
right = keyboard_check(ord("D"));
jump = keyboard_check(ord("W"));
link = keyboard_check_pressed(ord("J"));
unlink = keyboard_check_pressed(ord("K"));

if (onGround || !jump)
{
	climb = false;
}
else if (keyboard_check_pressed(ord("W")) && !onGround)
{
	climb = true;
}

move = (right - left) * moveSpeed;

// Check Status
landed = onGround;
onGround = place_meeting(x, y + 1, oSolid);

if (!onGround && canJump > 0)
{
	canJump--;
}
if (onGround)
{
	canJump = canJumpMax;
}

// Vertical Movement
if (vertSpeed + grav < maxFall) 
{
	vertSpeed += grav
}
else vertSpeed = maxFall;
if (jump && canJump > 0) vertSpeed = -jumpSpeed;

if (!place_meeting(x, y + vertSpeed, oSolid))
{
	y += vertSpeed;
}
else
{
	dir = sign(vertSpeed);
	while !place_meeting(x, y + dir, oSolid)
	{
		y += dir;
	}
	vertSpeed = 0;
}

// Horizontal Movement
if (!place_meeting(x + move, y, oSolid))
{
	x += move;
}
else
{
	dir = sign(move);
	while !place_meeting(x + dir, y, oSolid)
	{
		x += dir;
	}
}

// Pushing Objects
if (place_meeting(x + sign(move), y, oInteractable) && instance_nearest(x + sign(move), y, oInteractable).pushable) 
{
	pushMove = PushBox(sign(move), pushSpeed, instance_nearest(x + sign(move), y, oInteractable));
	if place_meeting(x + pushMove, y, oSolid) 
	{
		while !place_meeting(x + sign(pushMove), y, oSolid) 
		{
			x += sign(pushMove);
		}
	}
	else 
	{
		x += pushMove;
	}
	push = true;
}
else push = false;

// Link Action
if (link) 
{
	linkTarget = instance_nearest(x, y, oInteractable);
	if ((distance_to_object(linkTarget) <= linkDistance || (linkTarget.type == "saw" && distance_to_object(linkTarget) <= linkDistance + sawBuffer)) && !collision_line(x, y, linkTarget.x, linkTarget.y, oWall, false, true))
	{
		if (linkStart == noone)
		{
			linkStart = linkTarget;
		}
		else if (linkEnd == noone && linkTarget != linkStart)
		{
			linkEnd = linkTarget;
			linkStart.type = linkEnd.defaultType;
			linkEnd.type = linkStart.defaultType;
			
			tempAngle = linkStart.image_angle;
			tempTurretInvert = linkStart.turretInvert;
			tempShotRate = linkStart.shotRate;
			tempBulletSpeed = linkStart.bulletSpeed;
			tempSawStart = linkStart.sawStart;
			
			linkStart.image_angle = linkEnd.image_angle;
			linkStart.turretInvert = linkEnd.turretInvert;
			linkStart.shotRate = linkEnd.shotRate;
			linkStart.bulletSpeed = linkEnd.bulletSpeed;
			linkStart.sawStart = linkEnd.sawStart;
			
			linkEnd.image_angle = tempAngle;
			linkEnd.turretInvert = tempTurretInvert;
			linkEnd.shotRate = tempShotRate;
			linkEnd.bulletSpeed = tempBulletSpeed;
			linkEnd.sawStart = tempSawStart;
		}
	}
	else audio_play_sound(snCancel, 50, false);
}
if (unlink)
{
	if (linkEnd == noone)
	{
		if (linkStart != noone)
		{
			linkStart = noone;
		}
		audio_play_sound(snLinkBreak, 30, false);
	}
	else 
	{
		linkStart.type = linkStart.defaultType;
		linkEnd.type = linkEnd.defaultType;
		linkStart = noone;
		linkEnd = noone;
		audio_play_sound(snLinkBreak, 30, false);
	}
}

// Link Physics with Player
if (linkEnd == noone && linkStart != noone)
{
	linkLength = distance_to_object(linkStart);
	linkDir = point_direction(x, y, linkStart.x, linkStart.y);
	linkX = lengthdir_x(1, linkDir);
	linkY = lengthdir_y(1, linkDir);
	if (linkLength > linkMax) {
		pullCount = 0;
		while (!place_meeting(x + linkX, y + linkY, oSolid) && linkLength > linkMax && pullCount < 15)
		{
			x += linkX;
			y += linkY;
			linkLength = distance_to_object(linkStart);
			pullCount++;
		}
	}
	if (linkDir % 360 < 180 && !onGround)
	{
		if (climb) 
		{
			x += (linkStart.x - x)/100 - move;
			if (vertSpeed > 0) vertSpeed -= climbSpeed;
			climbCount = 0;
			while (!place_meeting(x + linkX, y + linkY, oSolid) && climbCount < climbSpeed)
			{
				x += linkX;
				y += linkY;
				climbCount += 1;
			}
		}
	}
}

// Link Physics between Objects
/*else if (linkEnd != noone) {
	linkLength = point_distance(linkStart.x, linkStart.y, linkEnd.x, linkEnd.y);
	if (linkLength > linkCompleteMax) {
		linkStart = noone;
		linkEnd = noone;
	}
}*/

// Damage
if place_meeting(x, y, oBullet)
{
	if (!audio_is_playing(snDeath)) audio_play_sound(snDeath, 150, false);
	instance_destroy(instance_nearest(x, y, oBullet));
	SlideTransition(TRANS_MODE.RESTART);
}

// Animation Handling
if (move != 0) image_xscale = sign(move);
if (onGround)
{
	image_speed = 1;
	if (move == 0) sprite_index = sPlayerIdle;
	else if (place_meeting(x + sign(move), y, oInteractable) && instance_nearest(x + sign(move), y, oInteractable).pushable) sprite_index = sPlayerPush;
	else sprite_index = sPlayerWalk;
}
else
{
	image_speed = 0;
	sprite_index = sPlayerAir;
	if (vertSpeed >= 0 || climb) image_index = 1;
	else image_index = 0;
}
if (move != 0) image_xscale = sign(move);

// Sound Handling
if (move != 0 && onGround && walkCooldown <= 0)
{
	if (!audio_is_playing(snWalk)) audio_play_sound(snWalk, 1, false);
	walkCooldown = 15;
}
walkCooldown -= 1;
if (onGround && !landed)
{
	audio_play_sound(snLanding, 2, false);
}
if (push)
{
	if (!audio_is_playing(snPush)) audio_play_sound(snPush, 10, true);
}
else audio_stop_sound(snPush);
if (linkStart != noone)
{
	if (!audio_is_playing(snLink)) audio_play_sound(snLink, 5, true);
}
else audio_stop_sound(snLink);