extends Node
class_name Grid

var grid: Array[Array]
signal grid_changed

func get_at_pos(x:int, y:int):
	pass

const grid_size = 128
func _init_grid():
	grid.resize(grid_size)
	for i in range(grid_size):
		grid[i].resize(128)

func _ready():
	_init_grid()
