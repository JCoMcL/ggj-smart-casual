extends Node
class_name Utils

func delay(secs):
	await get_tree().create_timer(secs).timeout
