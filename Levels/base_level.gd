extends Node3D
class_name Level

@export var level_size:float = 5

signal alert(Vector3)

const roomba_scn = preload("res://Entities/roomba.tscn")
const smartbox_scn = preload("res://Entities/precarious_boxes.tscn")
const human_scn = preload("res://Entities/human.tscn")
const fan_scn = preload("res://Entities/fan.tscn")
const door_scn = preload("res://Entities/door.tscn")

static func get_level(from: Node) -> Level:
	while from and from is not Level:
		from = from.get_parent()
	return from

func switcheroo(old:Node3D, new:PackedScene):
	var new_node = new.instantiate()
	new_node.position = old.position
	old.get_parent().add_child(new_node)
	old.free()

func _alert(v:Vector3):
	print("alert:",v)

func _ready():
	alert.connect(_alert)
	if $Level:
		for c:Node in $Level.get_children():
			if c.name.begins_with("Obj_Roomba"):
				switcheroo(c, roomba_scn)
			elif c.name.begins_with("obj_Smart_Box"):
				switcheroo(c, smartbox_scn)
			elif c.name.begins_with("rig"):
				print(switcheroo(c, human_scn))
			elif c.name.begins_with("obj_Smart_Fan"):
				switcheroo(c, fan_scn)
			elif c.name.begins_with("obj_Smart_Door"):
				switcheroo(c, door_scn)
			elif c is Camera3D:
				c.projection = Camera3D.PROJECTION_ORTHOGONAL
				c.size = level_size
