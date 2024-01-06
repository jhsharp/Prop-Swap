/// @description Manage Size and Position

// Update Camera State
if (keyboard_check(ord("L")))
{
	wTo = wMax;
	hTo = hMax;
	follow = oCenter;
}
else
{
	wTo = wMin;
	hTo = hMin;
	follow = oPlayer;
}

// Size
camWidth += (wTo - camWidth)/10;
camHeight += (hTo - camHeight)/10;

var pm = matrix_build_projection_ortho(camWidth, camHeight, 1, 10000);
camera_set_proj_mat(camera, pm);

// Position
if (follow != noone)
{
	xTo = follow.x;
	yTo = follow.y;
}

x += (xTo - x)/15;
y += (yTo - y)/15;

if (x - camWidth/2 < 0) x = camWidth/2;
if (x + camWidth/2 > room_width) x = room_width - camWidth/2;
if (y - camHeight/2 < 0) y = camHeight/2;
if (y + camHeight/2 > room_height) y = room_height - camHeight/2;

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
camera_set_view_mat(camera, vm);