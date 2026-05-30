extends Node
class_name Utils

func move(n:CollisionObject3D, dir:Vector3):
	var collision = n.move_and_collide(dir)
	if collision:
		var collided_object = collision.get_collider()
		if collided_object.has_method("nudge"):
			collided_object.nudge(dir)

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
