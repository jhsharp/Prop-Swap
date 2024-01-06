/// @desc Manage Music


if (room == rMenu)
{
	if !audio_is_playing(snMenu) audio_play_sound(snMenu, 5, true);	
}
else audio_stop_sound(snMenu);

if (room == rCredits)
{
	if !audio_is_playing(snCredits) audio_play_sound(snCredits, 5, true);
}
else audio_stop_sound(snCredits);

if (room == rLevel1) || (room == rLevel2) || (room == rLevel3) || (room == rLevel4)
{
	if !audio_is_playing(snArea1) audio_play_sound(snArea1, 5, true);
}
else audio_stop_sound(snArea1);

if (room == rLevel5) || (room == rLevel6) || (room == rLevel7) || (room == rLevel8)
{
	if !audio_is_playing(snArea2) audio_play_sound(snArea2, 5, true);
}
else audio_stop_sound(snArea2);

if (room == rLevel9)
{
	if !audio_is_playing(snArea3) audio_play_sound(snArea3, 5, true);
}
else audio_stop_sound(snArea3);