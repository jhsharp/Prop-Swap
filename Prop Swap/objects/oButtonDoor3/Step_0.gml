/// @description Open for Button

if (oButton3.active)
{
	sprite_index = sButtonDoorOpen3;
	if (!open)
	{
		open = true;
		audio_stop_sound(snDoorClose);
		audio_play_sound(snDoorOpen, 100, false);
	}
}
else 
{
	sprite_index = sButtonDoorClosed3;
	if place_meeting(x, y, oSolid) {
		sprite_index = sButtonDoorOpen3;
	}
	if (open)
	{
		open = false;
		audio_stop_sound(snDoorOpen);
		audio_play_sound(snDoorClose, 100, false);
	}
	if place_meeting(x, y, oPlayer) {
		if (!audio_is_playing(snDeath)) audio_play_sound(snDeath, 150, false);
		SlideTransition(TRANS_MODE.RESTART);
	}
}