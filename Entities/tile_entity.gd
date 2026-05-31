extends CharacterBody3D
class_name TileEntity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid.snap_to_grid(self)
	grid.update_pos(self)
	grid.step.connect(grid_step)
	grid.grid_changed.connect(grid_update)

func grid_step() -> void:
	pass

func grid_update() -> void:
	pass
