extends Control
class_name Tooltip

func _ready():
	var root = Root.get_root(self)
	if root:
		root.tooltip = self
var current_node: TileEntity
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_node:
		visible = true
		$Label.text = "Smart %s®" % current_node.name
		if current_node.click_action:
			$Panel.visible = true
			$Panel/Label.text = current_node.click_action
		else:
			$Panel.visible=false
	else:
		visible = false
	position = get_viewport().get_mouse_position()
