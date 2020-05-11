extends Node

func create_new_goodie(position, color_index, level_instance):
	var goodie = load("res://scenes/Goodie.tscn").instance()
	add_child(goodie)

	goodie.init(position, color_index, level_instance)

func get_current_goodies():
	return get_children()

func die():
	queue_free()
