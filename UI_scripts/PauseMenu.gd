extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Hide menu initially
	visible = false
	# Ensure menu works when game is paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	# Connect button signals
	$ResumeButton.pressed.connect(_on_resume_pressed)
	$MainMenuButton.pressed.connect(_on_main_menu_pressed)
	$QuitButton.pressed.connect(_on_quit_pressed)

	pass # Replace with function body.

# Toggle pause menu visibility
func toggle_pause():
	get_tree().paused = not get_tree().paused
	visible = true

# Resume button
func _on_resume_pressed():
	get_tree().paused = false
	visible = false

func _on_quit_pressed():
	get_tree().quit()

func _on_main_menu_pressed():
	Root.get_root(self).clear_level()
	_on_resume_pressed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
