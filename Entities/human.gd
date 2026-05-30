extends StaticBody3D
class_name Human

# Speed in pixels per second
@export var move_speed: float = 1.0

# Target position to move toward
var target_position: Vector3
var moving_x: bool = false
var moving_z: bool = false
var moving: bool = false

var stressLevel = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Example: set initial target
	target_position = position  # Start at current position
	moving_x = false
	moving_z = false
	moving = false

# Call to set the position in which move the human.
# xFirst: by passing true the human moves along x and then along z, viceversa if it's false
func set_target(xpos: float, zpos: float, xFirst: bool) -> void:
	# Validate input
	target_position = Vector3(xpos, position.y, zpos)
	moving_x = xFirst
	moving_z = !xFirst
	moving = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var velocity: Vector3 = Vector3.ZERO
	if moving_x:
		var dx = target_position.x - position.x
		if abs(dx) < 0.05:
			position.x = target_position.x
			moving_x = false
			if(moving):
				moving_z = true  # Switch to Z movement
				moving = false
		else:
			velocity.x += sign(dx) * move_speed * delta

	elif moving_z:
		var dz = target_position.z - position.z
		if abs(dz) < 0.05:
			position.z = target_position.z
			moving_z = false  # Done moving
			if(moving):
				moving_x = true
				moving = false
		else:
			velocity.z += sign(dz) * move_speed * delta
			
	if velocity != Vector3.ZERO:
		move_and_collide(velocity)

func nudge(direction: Vector3):
	# dummy "stressLevel"
	stressLevel += 1
	print("Human collided, stress level: ", stressLevel)
