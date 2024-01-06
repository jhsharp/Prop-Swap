/// @description Draw Self and Link

draw_self();

// Draw Link
depth = layer_get_depth("Link");

if (linkEnd != noone)
{
	draw_line_width_color(linkStart.x, linkStart.y, linkEnd.x, linkEnd.y, 5, c_purple, c_purple);
}
else if (linkStart != noone)
{
	draw_line_width_color(x, y, linkStart.x, linkStart.y, 5, c_purple, c_purple);
}

depth = layer_get_depth("Player");