extends CharacterBody3D
class_name TileEntity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid.snap_to_grid(self)
	var pos = grid.get_object_grid_pos(self)
	grid.set_at_pos(self, pos.x, pos.y)
	grid.step.connect(grid_step)

func grid_step() -> void:
	pass
