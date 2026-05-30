extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		print(position)
		position.x += 1
	if Input.is_action_just_pressed("down"):
		print(position)
		position.x -= 1	
	if Input.is_action_just_pressed("left"):
		print(position)
		position.y += 1
	if Input.is_action_just_pressed("right"):
		print(position)
		position.y -= 1	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		position.z+=1
	if event.is_action_pressed("ui_down"):
		position.z-=1	
