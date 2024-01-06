/// @description PushBox(direction, distance, target)

function PushBox() {

	target = argument[2];

	with (target) {
		dir = argument[0];
		distance = argument[1];
		move = dir * distance;

		if (place_meeting(x + dir, y, oInteractable) && instance_nearest(x + (48 * dir), y, oInteractable).pushable) {
			move = PushBox(dir, distance, instance_nearest(x + (48 * dir), y, oInteractable));
			x += move;
			return move;
		}
		else if (place_meeting(x + move, y, oSolid)) {
			moveReturn = 0;
			while !place_meeting(x + sign(move), y, oSolid) {
				moveReturn += sign(move);
				x += sign(move);
			}
			return moveReturn;
		}
		else {
			x += move
			return move;
		}
	}


}
