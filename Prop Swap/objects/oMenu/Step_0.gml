/// @description Control menu

//Item ease in
menu_x += (menu_x_target - menu_x) / menu_speed;

//Keyboard controls
if (menu_control)
{
	if (keyboard_check_pressed(vk_up)) || (keyboard_check_pressed(ord("W")))
	{
		menu_cursor++;
		if (menu_cursor >= menu_items) menu_cursor = 0;
	}
	if (keyboard_check_pressed(vk_down)) || (keyboard_check_pressed(ord("S")))
	{
		menu_cursor--;
		if (menu_cursor < 0) menu_cursor = menu_items - 1;
	}
	if (keyboard_check_pressed(vk_enter))
	{
		menu_x_target = gui_width + 750;
		menu_committed = menu_cursor;
		menu_control = false;
		audio_play_sound(snCancel, 50, false);
	}
	
	var mouse_y_gui = device_mouse_y_to_gui(0);
	if (mouse_y_gui < menu_y) && (mouse_y_gui > menu_top)
	{
		menu_cursor = (menu_y - mouse_y_gui) div (menu_itemheight * gap)
		if (mouse_check_button_pressed(mb_left))
		{
			menu_x_target = gui_width + 750;
			menu_committed = menu_cursor;
			menu_control = false;
			audio_play_sound(snCancel, 50, false);
		}
	}
}

if (menu_x > gui_width + 500) && (menu_committed != -1)
{
	switch (menu_committed)
	{
		case 2: SlideTransition(TRANS_MODE.NEXT); break;
		case 1: 
		{
			if (!file_exists(SAVEFILE))
			{
				SlideTransition(TRANS_MODE.NEXT);
			}
			else
			{
				var file = file_text_open_read(SAVEFILE);
				var target = file_text_read_real(file);
				file_text_close(file);
				if (target != rInitialize) && (target != rMenu) && (target != rCredits) {
					SlideTransition(TRANS_MODE.GOTO, target);
				}
				else SlideTransition(TRANS_MODE.NEXT);
			}
			break;
		}
		case 0: game_end(); break;
	}
}