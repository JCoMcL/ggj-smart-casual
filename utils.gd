extends Node
class_name Utils


func register(n: Node3D):
	grid.snap_to_grid(n)
	var pos = grid.get_object_grid_pos(n)
	grid.set_at_pos(n, pos.x, pos.y)

func delay(secs):
	await get_tree().create_timer(secs).timeout
