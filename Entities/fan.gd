extends TileEntity

var high_power = false

func _ready() -> void:
	super()
	$NoiseHigh.playing = high_power
	$NoiseLow.playing = true

func grid_update():
	if high_power:
		var grid_pos = grid.get_object_grid_pos(self)
		var infront = grid.get_at_pos(grid_pos.x +1, grid_pos.y)
		if infront is TileEntity:
			grid.move(infront, Vector3.RIGHT)

func _on_click():
	high_power = not high_power
	$NoiseHigh.playing = high_power
