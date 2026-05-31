extends TileEntity

func nudge(direction: Vector3) -> bool:
	var collision = move_and_collide(direction, true)
	if collision:
		var col = collision.get_collider()
		if col is Human:
			grid.remove(col)
			col.get_parent().remove_child(col)
	var pos_before_move = position
	grid.move(self, direction)
	return position != pos_before_move
