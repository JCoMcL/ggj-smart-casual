extends StaticBody3D

var stressLevel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func nudge(direction: Vector3):
	# dummy "stressLevel"
	stressLevel += 1
	print("Human collided, stress level: ", stressLevel)
