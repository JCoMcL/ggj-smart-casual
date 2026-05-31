extends TileEntity

func _ready() -> void:
	click_action = "Ring"

func _on_click():
	$AudioStreamPlayer3D.play()
	var level = Level.get_level(self)
	if level:
		level.alert.emit(global_position)
