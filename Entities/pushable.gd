extends StaticBody3D

func _ready() -> void:
	utils.register(self)

func _process(delta: float) -> void:
	pass

func nudge(direction: Vector3) -> bool:
	grid.move(self, direction)
	return true
