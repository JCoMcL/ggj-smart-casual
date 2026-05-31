extends TileEntity
class_name Human

var target_position: Vector3
var is_moving: bool = false
var x_first: bool = true
var animPlayer: AnimationPlayer
var currentAnimation: StringName = ""

var stressLevel = 0

var animationDict = {
	"IDLE": "rigAction_002",
	"WALK": "rigAction_004",
	"CONFUSE": "rigAction_005",
	"DIE": "rigAction_007"
}

func _ready() -> void:
	super()
	target_position = position
	var level = Level.get_level(self)
	if level:
		level.alert.connect(_alert)
	else:
		print(self, "failed to find level")

	animPlayer = get_node("obj_Human/AnimationPlayer")
	animPlayer.animation_finished.connect(_on_animation_finished)
	_play_animation("IDLE")

func _alert(alert_pos: Vector3):
	print(self)
	set_target(alert_pos, true)

func set_target(t: Vector3, xFirst: bool) -> void:
	target_position = Vector3(t.x, position.y, t.z)
	x_first = xFirst
	is_moving = true
	_play_animation("WALK")

func grid_step() -> void:
	if not is_moving:
		return
	var cur := grid.get_object_grid_pos(self)
	var tgt := grid.world_to_grid(target_position)

	if cur == tgt:
		is_moving = false
		_play_animation("IDLE")
		return

	var dx = tgt.x - cur.x
	var dz = tgt.y - cur.y
	var dir := Vector2i.ZERO

	if x_first:
		if dx != 0:
			dir.x = sign(dx)
		else:
			dir.y = sign(dz)
	else:
		if dz != 0:
			dir.y = sign(dz)
		else:
			dir.x = sign(dx)

	face_direction(Vector3(dir.x, 0, dir.y))

	var next := cur + dir
	var occupant = grid.get_at_pos(next.x, next.y)
	var move_dir3 := Vector3(dir.x, 0, dir.y) * grid.tiles_size

	grid.move(self, move_dir3)

func face_direction(dir: Vector3) -> void:
	if dir != Vector3.ZERO:
		$obj_Human.rotation.y = atan2(dir.x, dir.z)

func nudge(direction: Vector3) -> bool:
	stressLevel += 1
	if currentAnimation != animationDict["DIE"]:
		face_direction(direction)
		_play_animation("CONFUSE")
	print("Human collided, stress level: ", stressLevel)
	return false

# Called externally (e.g. by precarious_boxes) — direction used to orient the fall.
func setCurrentAnimation(anim_name: StringName, direction: Vector3 = Vector3.ZERO) -> void:
	if anim_name == "DIE":
		is_moving = false
	if direction != Vector3.ZERO:
		# Die animation faces 90° clockwise from the impact direction
		var fall_dir := Vector3(direction.z, 0, -direction.x) if anim_name == "DIE" else direction
		face_direction(fall_dir)
	_play_animation(anim_name)

func _play_animation(key: StringName) -> void:
	var anim: StringName = animationDict[key]
	if anim == currentAnimation:
		return
	currentAnimation = anim
	animPlayer.play(anim)

func _on_animation_finished(anim_name: StringName):
	if anim_name == animationDict["DIE"]:
		collision_layer = 0
		currentAnimation = ""
		Root.get_root(self).next_level()
	elif anim_name == animationDict["IDLE"]:
		currentAnimation = ""
		_play_animation("IDLE")
	elif anim_name == animationDict["WALK"]:
		if is_moving:
			currentAnimation = ""
			_play_animation("WALK")
		else:
			_play_animation("IDLE")
	elif anim_name == animationDict["CONFUSE"]:
		if is_moving:
			_play_animation("WALK")
		else:
			_play_animation("IDLE")
