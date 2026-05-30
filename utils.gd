extends Node
class_name Utils

func move(n: CollisionObject3D, dir: Vector3):
	var grid = _get_grid(n)
	var start_pos = n.global_position
	var target_pos: Vector3
	if grid:
		target_pos = grid.snapped_to_grid(start_pos + dir)
	else:
		target_pos = start_pos + dir
	var move_vec = Vector3(target_pos.x - start_pos.x, 0, target_pos.z - start_pos.z)

	var collision = n.move_and_collide(move_vec)

	if collision:
		var collider = collision.get_collider()
		var nudge_success = collider.has_method("nudge") and collider.nudge(dir)
		if nudge_success:
			n.global_position.x = target_pos.x
			n.global_position.z = target_pos.z
		else:
			n.global_position = start_pos
			return
	else:
		n.global_position.x = target_pos.x
		n.global_position.z = target_pos.z

	if grid:
		var pos = grid.get_object_grid_pos(n)
		grid.set_at_pos(n, pos.x, pos.y)

func register(n: Node3D):
	var grid = _get_grid(n)
	if grid:
		print("pos before", n.global_position)
		grid.snap_to_grid(n)
		print("pos after", n.global_position)
		var pos = grid.get_object_grid_pos(n)
		grid.set_at_pos(n, pos.x, pos.y)

func delay(secs):
	await get_tree().create_timer(secs).timeout

func _get_grid(n: Node) -> Grid:
	var root = Root.get_root(n)
	return root.grid if root else null
