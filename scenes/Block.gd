extends "res://scenes/Cell.gd"

func modulate_color(new_color_index):
	color_index = new_color_index
	apply_color()
	
func apply_color():
	if color_index >= 0:
		var color = Globals.colors[color_index]
		$Sprite.self_modulate = color
		#$Sprite.modulate = color
		$Light.color = color
	else:
		$Light.enabled = false

func die():
	queue_free()
