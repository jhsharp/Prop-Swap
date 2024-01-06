/// @description GUI/Vars/Menu setup
#macro SAVEFILE "Save.sav"

gui_width = 1024;
gui_height = 768;
gui_margin = 96;
gap = 2.5 //Multiplier for space between menu items

menu_x = gui_width + 200;
menu_y = gui_height - gui_margin;
menu_x_target = gui_width - gui_margin;
menu_speed = 25; //lower is faster
menu_font = fMenu;
menu_itemheight = font_get_size(fMenu);
menu_committed = -1;
menu_control = true;

menu[2] = "New Game   ";
menu[1] = "Continue   ";
menu[0] = "Quit   ";

menu_items = array_length_1d(menu);

menu_top = menu_y - ((menu_itemheight * gap) * menu_items)

menu_cursor = 2;