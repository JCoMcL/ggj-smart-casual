extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide menu initially
	visible = false
	# Ensure menu works when game is paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
