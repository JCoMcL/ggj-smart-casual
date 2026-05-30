extends CharacterBody3D

func nudge(direction: Vector3):
	print("boxes nudged", direction)
	var collision = move_and_collide(direction, true)
	if collision:
		var col = collision.get_collider()
		if col is Human:
			col.queue_free()
