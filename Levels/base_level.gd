extends Node3D

const roomba_scn = preload("res://Entities/roomba.tscn")
const smartbox_scn = preload("res://Entities/precarious_boxes.tscn")
const human_scn = preload("res://Entities/human.tscn")

func switcheroo(old:Node3D, new:PackedScene):
	var new_node = new.instantiate()
	old.get_parent().add_child(new_node)
	new_node.position = old.position
	old.free()

func _ready():
	if $Level:
		for c:Node in $Level.get_children():
			if c.name.begins_with("Obj_Roomba"):
				switcheroo(c, roomba_scn)
			elif c.name.begins_with("obj_Smart_Box"):
				switcheroo(c, smartbox_scn)
			elif c.name.begins_with("obj_Human"):
				switcheroo(c, human_scn)
