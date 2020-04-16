extends Node

var min_length

func check_win():
	return get_parent().get_node("Player").length >= min_length
