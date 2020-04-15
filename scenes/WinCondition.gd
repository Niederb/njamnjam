extends Node

func check_win():
	return get_parent().get_node("Blocks").get_child_count() == 0
