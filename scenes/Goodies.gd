extends Node

func create_new_goodie(position, color_index):
	var body_part = load("res://scenes/Goodie.tscn").instance()
	add_child(body_part)

	body_part.init(position, color_index)

func get_current_goodies():
	return get_children()

func die():
	queue_free()
