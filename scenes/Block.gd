extends "res://Cell.gd"

func modulate_color(new_color_index):
	color_index = new_color_index
	var color = Globals.colors[color_index]
	$Sprite.modulate = color
	$Light.color = color

func die():
	queue_free()
