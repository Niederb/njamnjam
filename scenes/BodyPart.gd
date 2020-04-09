extends Node2D

var color_index = -1

func modulate_color(new_color_index):
	color_index = new_color_index
	var color = Globals.colors[color_index]
	$Sprite.modulate = color

func get_color_index():
	return color_index

func die():
	queue_free()
