extends TileEntity
class_name Roomba

func _ready() -> void:
	super()

func move(direction:Vector3):
	$AudioStreamPlayer3D.play()
	grid.sync()
	grid.move(self, direction)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		move(Vector3.FORWARD)
	elif event.is_action_pressed("down"):
		move(Vector3.BACK)
	elif event.is_action_pressed("left"):
		move(Vector3.LEFT)
	elif event.is_action_pressed("right"):
		move(Vector3.RIGHT)

	elif event.is_action_pressed("undo"):
		grid.undo()
