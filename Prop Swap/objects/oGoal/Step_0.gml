/// @description Next Room

if place_meeting(x, y, oPlayer)
{
	audio_play_sound(snComplete, 150, false);
	SlideTransition(TRANS_MODE.GOTO, nextRoom);
}