extends TileEntity
class_name Pushable

func nudge(direction: Vector3) -> bool:
	var pos_before_move = position
	grid.move(self, direction)
	return position != pos_before_move
