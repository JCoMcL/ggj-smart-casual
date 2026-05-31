extends CharacterBody3D
class_name TileEntity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_ray_pickable = true
	grid.snap_to_grid(self)
	grid.update_pos(self)
	grid.step.connect(grid_step)
	grid.grid_changed.connect(grid_update)

func grid_step() -> void:
	pass

func grid_update() -> void:
	pass

func _on_click():
	print(self, "clicked")

func _input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (
			event is InputEventMouseButton and
			event.pressed and
			event.button_index == MOUSE_BUTTON_LEFT
	):
		_on_click()
