extends TileEntity

func nudge(direction: Vector3) -> bool:
	var collision = move_and_collide(direction, true)
	if collision:
		var col = collision.get_collider()
		if col is Human:
			col.collision_layer = 0
			col.setCurrentAnimation("DIE")
	collision = grid.move(self, direction)
	if not collision:
		$AudioStreamPlayer3D.play()
		rotation.x = direction.z * PI / 2
		rotation.z = direction.x * -PI / 2
		collision_layer = 0
		return true
	return false
