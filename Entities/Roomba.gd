extends CharacterBody3D
class_name Roomba

func _ready() -> void:
	var root = Root.get_root(self)
	if root:
		root.roomba = self
	utils.register(self)

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		utils.move(self, Vector3.FORWARD)
	elif event.is_action_pressed("down"):
		utils.move(self, Vector3.BACK)
	elif event.is_action_pressed("left"):
		utils.move(self, Vector3.LEFT)
	elif event.is_action_pressed("right"):
		utils.move(self, Vector3.RIGHT)
