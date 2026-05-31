extends TileEntity

func _on_click():
	$AudioStreamPlayer3D.play()
	var level = Level.get_level(self)
	if level:
		level.alert.emit(global_position)
