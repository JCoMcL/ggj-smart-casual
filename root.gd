extends Control
class_name Root

@onready var pause_menu = %PauseMenu

var current_level:StringName
var SCENES = {
	&"1": load("res://Levels/level_1.tscn"),
	&"2": load("res://Levels/level_2.tscn"),
	&"3": load("res://Levels/level_3.tscn")
}

func clear_level():
	%LevelSelect.visible = false
	$SubViewportContainer.visible = false
	for c in %SubViewport.get_children():
		%SubViewport.remove_child(c)
	

func change_scene(id:StringName):
	assert(SCENES.has(id))
	grid.clear()
	%LevelSelect.visible = false
	var level_scn = SCENES[id]
	var level = level_scn.instantiate()
	clear_level()
	%SubViewport.add_child(level)
	current_level = id
	$SubViewportContainer.visible = true

func restart():
	change_scene(current_level)

func _ready() -> void:
	$SubViewportContainer.visible=false
	
static func get_root(from: Node) -> Root:
	while from and from is not Root:
		from = from.get_parent()
	return from
	
func _input(event):
	if event.is_action_pressed("ui_cancel") && not is_main_menu(): # Default Esc key
		pause_menu.set_paused(true)
	elif event.is_action_pressed("reset"):
		restart()

func is_main_menu():
	return not $SubViewportContainer.visible
