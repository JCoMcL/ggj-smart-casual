extends CharacterBody3D
class_name TileEntity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid.snap_to_grid(self)
	grid.update_pos(self)
	grid.step.connect(grid_step)
	print(grid.node_positions)

func grid_step() -> void:
	pass
