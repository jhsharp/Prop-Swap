/// @description Destroy on Solid Hit

/*cooldown -= 1;*/
turretCollide = false;

if (place_meeting(x, y, oInteractable))
{
	if (instance_nearest(x, y, oInteractable).type = "turret") turretCollide = true;
}

if (place_meeting(x, y, oSolid) && !place_meeting(x, y, oBreakableWall)  && !turretCollide /*&& cooldown <= 0*/)
{
	instance_destroy(self);
}