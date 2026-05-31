extends TileEntity
class_name Human

var target_position: Vector3
var moving_x: bool = false
var moving_z: bool = false
var moving: bool = false
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
	currentAnimation = animationDict["IDLE"]

	# Connect the signal to a local function
	animPlayer.animation_finished.connect(_on_animation_finished)

func _alert(alert_pos:Vector3):
	print(self)
	set_target(alert_pos, true)

# Call to set the position to move the human toward.
# xFirst: moves along x then z when true, z then x when false.
func set_target(t:Vector3, xFirst: bool) -> void:
	target_position = Vector3(t.x, position.y, t.z)
	moving_x = xFirst
	moving_z = !xFirst
	moving = true
	currentAnimation = animationDict["WALK"]

func grid_step() -> void:
	if not moving_x and not moving_z:
		return
	var cur := grid.get_object_grid_pos(self)
	var tgt := grid.world_to_grid(target_position)
	var dir := Vector2i.ZERO
	if moving_x:
		var dx = tgt.x - cur.x
		if dx == 0:
			moving_x = false
			if moving:
				moving_z = true
				moving = false
			return
		dir.x = sign(dx)
	elif moving_z:
		var dz = tgt.y - cur.y
		if dz == 0:
			moving_z = false
			if moving:
				moving_x = true
				moving = false
			return
		dir.y = sign(dz)
	var next := cur + dir
	var occupant = grid.get_at_pos(next.x, next.y)
	var move_dir3 := Vector3(dir.x, 0, dir.y) * grid.tiles_size
	if occupant == null:
		var world_pos := grid.grid_to_world(next.x, next.y)
		global_position = Vector3(world_pos.x, global_position.y, world_pos.z)
		grid.set_at_pos(self, next.x, next.y)
	elif occupant.has_method("nudge") and occupant.nudge(move_dir3):
		var world_pos := grid.grid_to_world(next.x, next.y)
		global_position = Vector3(world_pos.x, global_position.y, world_pos.z)
		grid.set_at_pos(self, next.x, next.y)
	currentAnimation = animationDict["IDLE"] 

func nudge(direction: Vector3) -> bool:
	stressLevel += 1
	currentAnimation = animationDict["CONFUSE"]
	print("Human collided, stress level: ", stressLevel)
	return false

func _process(delta: float) -> void:
	playCurrentAnimation()
	pass

func playCurrentAnimation():
	if(animPlayer && (currentAnimation != "")):
		animPlayer.play(currentAnimation)

func setCurrentAnimation(anim_name: StringName):
	currentAnimation = animationDict[anim_name]

func _on_animation_finished(anim_name: StringName):
	if anim_name == animationDict["DIE"]:
		collision_layer = 0
		currentAnimation = ""
		Root.get_root(self).next_level()
	elif anim_name == animationDict["CONFUSE"]:
		if moving:
			currentAnimation = animationDict["WALK"]
		else:
			currentAnimation = animationDict["IDLE"]
