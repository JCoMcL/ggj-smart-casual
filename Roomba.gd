extends CharacterBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# how to detect boundaries
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		move_and_collide(Vector3.FORWARD)
	elif event.is_action_pressed("down"):
		move_and_collide(Vector3.BACK)
	elif event.is_action_pressed("left"):
		move_and_collide(Vector3.LEFT)
	elif event.is_action_pressed("right"):
		var collidedObj = move_and_collide(Vector3.RIGHT)
		if collidedObj:
			collidedObj.get_collider().nudge(Vector3.RIGHT)
