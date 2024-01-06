/// @description Press Button

if (place_meeting(x + lengthdir_x(10, image_angle + 90), y + lengthdir_y(10, image_angle + 90), oInteractable) || place_meeting(x + lengthdir_x(10, image_angle + 90), y + lengthdir_y(10, image_angle + 90), oPlayer))
{
	active = true;
	image_index = 1;
}
else
{
	active = false;
	image_index = 0;
}