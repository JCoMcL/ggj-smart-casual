extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide menu initially
	visible = false
	# Ensure menu works when game is paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	# Connect button signals
	%ResumeButton.pressed.connect(_on_resume_pressed)

# Toggle pause menu visibility
func toggle_pause():
	set_paused(not visible)

func set_paused(b:bool):
	get_tree().paused = b
	visible = b
# Resume button
func _on_resume_pressed():
	get_tree().paused = false
	visible = false

# this doesn't work, idk why
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		set_paused(false)
