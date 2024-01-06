/// @description Set Variables and Create Camera


moveSpeed = 6;
pushSpeed = 4;
pushMove = 0;
push = false;

vertSpeed = 0;
jumpSpeed = 13;
grav = 1;
maxFall = jumpSpeed;

onGround = false;
landed = false;
canJumpMax = 5; // Coyote Time
canJump = canJumpMax;

linkStart = noone;
linkEnd = noone;
linkTarget = noone;
linkDistance = 50;
sawBuffer = 25;
linkLength = 0;
linkMax = 300;
/*linkCompleteMax = 500;*/
pullCount = 0;

climb = false;
climbSpeed = 3;

keys = 0;

walkCooldown = 30;

instance_create_depth(x, y, 0, oCamera);