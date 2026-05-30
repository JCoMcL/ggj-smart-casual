extends StaticBody3D

func _ready() -> void:
	_register_on_grid.call_deferred()

func _process(delta: float) -> void:
	pass

func nudge(direction: Vector3) -> bool:
	utils.move(self, direction)
	return true

func _register_on_grid():
	utils.register(self)
