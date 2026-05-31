extends Pushable

var high_power = false

const RATTLE_POS_LOW = 0.004
const RATTLE_POS_HIGH = 0.018
const RATTLE_ROT_LOW = 0.008
const RATTLE_ROT_HIGH = 0.035

func _ready() -> void:
	super()
	click_action = "Toggle"
	$NoiseHigh.playing = high_power
	$NoiseLow.playing = true

func _process(_delta: float) -> void:
	var p = RATTLE_POS_HIGH if high_power else RATTLE_POS_LOW
	var r = RATTLE_ROT_HIGH if high_power else RATTLE_ROT_LOW
	$obj_SmartFan.position = Vector3(
		randf_range(-p, p),
		randf_range(-p * 0.4, p * 0.4),
		randf_range(-p, p)
	)
	$obj_SmartFan.rotation = Vector3(
		randf_range(-r, r),
		randf_range(-r, r),
		randf_range(-r, r)
	)

func grid_update():
	print("fan update")
	if high_power:
		var grid_pos = grid.get_object_grid_pos(self)
		var blow_pos = grid.get_object_grid_pos($BlowTarget)
		var infront = grid.get_at_pos(blow_pos.x, blow_pos.y)
		var blow_direction = blow_pos-grid_pos
		if infront is TileEntity:
			grid.move(infront, Vector3(blow_direction.x, 0, blow_direction.y))

func _on_click():
	high_power = not high_power
	$NoiseHigh.playing = high_power
	grid_update()
