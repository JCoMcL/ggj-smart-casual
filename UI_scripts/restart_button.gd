extends BaseButton

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed():
	Root.get_root(self).restart()
	%PauseMenu.set_paused(false)
