extends CharacterBody3D

func nudge(direction: Vector3):
	var collision = move_and_collide(direction, true)
	if collision:
		var col = collision.get_collider()
		if col is Human:
			col.get_parent().remove_child(col)
			col.queue_free()
	grid.move(self, direction)
