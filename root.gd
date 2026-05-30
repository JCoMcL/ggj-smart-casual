extends Control
class_name Root

var roomba: Roomba

var SCENES = {
	&"1": preload("res://Levels/level_1.tscn"),
}

func clear_level():
	$SubViewportContainer.visible = false
	for c in %SubViewport.get_children():
		%SubViewport.remove_child(c)
	
	
func change_scene(id:StringName):
	assert(SCENES.has(id))
	var level_scn = SCENES[id]
	var level = level_scn.instantiate()
	clear_level()
	%SubViewport.add_child(level)
	$SubViewportContainer.visible = true

func _ready() -> void:
	$SubViewportContainer.visible=false
	
static func get_root(from: Node) -> Root:
	while from and from is not Root:
		from = from.get_parent()
	return from
