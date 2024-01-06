/// @description Open for Player with Keys

if (oPlayer.keys > 0 && (place_meeting(x+1, y, oPlayer) || place_meeting(x-1, y, oPlayer)|| place_meeting(x, y+1, oPlayer) || place_meeting(x, y-1, oPlayer)))
{
	audio_play_sound(snKeyDoor, 100, false);
	oPlayer.keys--;
	instance_destroy(self);
}