/// @description Destroy on Bullet

if place_meeting(x, y, oBullet)
{
	audio_play_sound(snWallBreak, 100, false);
	instance_destroy(instance_nearest(x, y, oBullet));
	instance_destroy(self);
}