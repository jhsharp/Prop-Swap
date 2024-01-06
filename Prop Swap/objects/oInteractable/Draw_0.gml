/// @description Draw Self and Col

draw_self();

if (type != defaultType)
{
	depth = layer_get_depth("Col");

	if (defaultType = "box") 
	{
		draw_sprite(sBoxCol, 0, x, y);
	}
	if (defaultType = "spikes") 
	{
		draw_sprite(sSpikesCol, 0, x, y);
	}
	if (defaultType = "key")
	{
		draw_sprite(sKeyCol, 0, x, y);
	}
	if (defaultType = "turret")
	{
		draw_sprite(sTurretCol, 0, x, y);
	}
	if (defaultType = "saw")
	{
		draw_sprite(sSawCol, 0, x, y);
	}
}

depth = layer_get_depth("Interactables");