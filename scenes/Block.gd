extends "res://scenes/Cell.gd"

func modulate_color(new_color_index):
	color_index = new_color_index
	apply_color()
	
func apply_color():
	var color = Globals.colors[color_index]
	$Sprite.modulate = color
	$Light.color = color

func die():
	queue_free()
