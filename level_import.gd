@tool # Needed so it runs in editor.
extends EditorScenePostImport

var root_scene: Node
func _post_import(scene):
	root_scene=scene
	iterate(scene)
	return scene

func iterate(node: Node):
	if node != null:
		if node is Light3D:
			print("light:", node, node.light_energy)
			node.light_energy /= 10000
			print(node.light_energy)
			node.shadow_enabled = true

		for child in node.get_children():
			iterate(child)
