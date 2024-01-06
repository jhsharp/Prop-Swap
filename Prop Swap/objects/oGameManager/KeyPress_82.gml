/// @description Restart Room

if (!audio_is_playing(snDeath)) audio_play_sound(snDeath, 150, false);
SlideTransition(TRANS_MODE.RESTART);