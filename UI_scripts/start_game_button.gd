extends BaseButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)
	pass # Replace with function body.

func _on_pressed():
	Root.get_root(self).change_scene("1")
