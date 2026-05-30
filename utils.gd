extends Node
class_name Utils

func move(n:CollisionObject3D, dir:Vector3):
	var collision = n.move_and_collide(dir)
	if collision:
		var collided_object = collision.get_collider()
		if collided_object.has_method("nudge"):
			collided_object.nudge(dir)

func delay(secs):
	await get_tree().create_timer(secs).timeout
