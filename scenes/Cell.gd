extends Node2D

var sub_graph_id = -1
var color_index = -1
var active = true
var id = -1

func get_color_index():
	return color_index

func is_active():
	return active

func processed():
	return sub_graph_id != -1

func reset(new_id):
	id = new_id
	sub_graph_id = -1
