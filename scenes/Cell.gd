extends Node2D

var sub_graph_id: int = -1
export var color_index: int = -1
var active: bool = true
var id: int = -1

func get_color_index():
	return color_index

func is_active():
	return active

func processed():
	return sub_graph_id != -1

func reset(new_id):
	id = new_id
	sub_graph_id = -1
