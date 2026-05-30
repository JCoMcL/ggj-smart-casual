extends Node
class_name Utils

func move(n: PhysicsBody3D, dir: Vector3):
	var grid = utils._get_grid(self)
	var initial_pos = n.global_position
	if grid:
		initial_pos = grid.snapped_to_grid(initial_pos)

	var delta = dir
	if grid:
		delta = delta.normalized() * grid.tiles_size

	var target = initial_pos + delta
	if grid:
		target = grid.snapped_to_grid(target) #shouldn't be neccessary but doesn't hurt

	var collision = n.move_and_collide(delta)
	if collision:
		var col = collision.get_collider()
		if col and col.has_method("nudge"):
			col.nudge(delta)
		n.global_position = initial_pos


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
