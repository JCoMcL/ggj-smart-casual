extends Control
class_name Root

var SCENES = {
	&"1": preload("res://test_level.tscn"),
	&"2": preload("res://test_level_2.tscn"),
}

func change_scene(id:StringName):
	assert(SCENES.has(id))
	var level_scn = SCENES[id]
	var level = level_scn.instantiate()
	for c in %SubViewport.get_children():
		%SubViewport.remove_child(c)
	%SubViewport.add_child(level)

func _ready() -> void:
	change_scene("1")
	
