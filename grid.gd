extends Node
class_name Grid

var grid: Array[Array]
signal grid_changed

const grid_size = 128
const tiles_size = 1.0

func grid_to_world(x: int, y: int) -> Vector3:
	return Vector3(x * tiles_size, 0, y * tiles_size)

func world_to_grid(v: Vector3) -> Vector2i:
	return Vector2i(roundi(v.x / tiles_size), roundi(v.z / tiles_size))

func get_object_grid_pos(n: Node) -> Vector2i:
	var node3d := n as Node3D
	if node3d == null:
		return Vector2i.ZERO
	return world_to_grid(Vector3(node3d.global_position.x, 0, node3d.global_position.z))

func snapped_to_grid(v: Vector3) -> Vector3:
	return Vector3(roundi(v.x / tiles_size) * tiles_size, 0, roundi(v.z / tiles_size) * tiles_size)

func snap_to_grid(n: Node3D):
	var snapped_pos = snapped_to_grid(n.global_position)
	n.global_position.x = snapped_pos.x
	n.global_position.z = snapped_pos.z

func _to_index(coord: int) -> int:
	return grid_size / 2 + coord

func _in_bounds(x: int, y: int) -> bool:
	var ix := _to_index(x)
	var iy := _to_index(y)
	return ix >= 0 and ix < grid_size and iy >= 0 and iy < grid_size

func get_at_pos(x: int, y: int) -> Node:
	if not _in_bounds(x, y):
		return null
	return grid[_to_index(x)][_to_index(y)]

func set_at_pos(n: Node, x: int, y: int) -> bool:
	if not _in_bounds(x, y):
		return false
	var ix := _to_index(x)
	var iy := _to_index(y)
	if grid[ix][iy] != null and grid[ix][iy] != n:
		return false
	for i in range(grid_size):
		for j in range(grid_size):
			if grid[i][j] == n:
				grid[i][j] = null
	grid[ix][iy] = n
	grid_changed.emit()
	return true

func _init_grid():
	grid.resize(grid_size)
	for i in range(grid_size):
		grid[i].resize(grid_size)

func _ready():
	_init_grid()
	var root = Root.get_root(self)
	if root:
		root.grid = self
