extends Control
class_name Root

@onready var pause_menu = %PauseMenu

var tooltip:Tooltip

var current_level:int
var SCENES = [
	load("res://Levels/level_1.tscn"),
	load("res://Levels/level_2.tscn"),
	load("res://Levels/level_3.tscn"),
	load("res://Levels/level_4.tscn")
]

func clear_level():
	%LevelSelect.visible = false
	$SubViewportContainer.visible = false
	for c in %SubViewport.get_children():
		%SubViewport.remove_child(c)

func next_level():
	var nextLevel = current_level + 1
	if nextLevel >= SCENES.size():
		#TODO when we have GAME WIN UI
		print("GAME WIN")
		$TextureRectEndScreen.visible=true
	else:
		await utils.delay(1.0)
		change_scene(nextLevel)

func change_scene(id:int):
	assert(id < SCENES.size())
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
	%StartGameButton.grab_focus()

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
