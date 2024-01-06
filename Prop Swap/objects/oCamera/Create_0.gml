/// @description

follow = oPlayer;
xTo = x;
yTo = y;

wMin = 1024;
hMin = 768;
wMax = room_width;
hMax = room_height;
wTo = wMin;
hTo = hMin;
camWidth = wTo;
camHeight = hTo;

instance_create_depth(room_width/2, room_height/2, 0, oCenter);

camera = camera_create();

var vm = matrix_build_lookat(x, y, -10, x, y, 0, 0, 1, 0);
var pm = matrix_build_projection_ortho(camWidth, camHeight, 1, 10000);

camera_set_view_mat(camera, vm);
camera_set_proj_mat(camera, pm);

view_camera[0] = camera;