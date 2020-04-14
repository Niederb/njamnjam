extends "res://scenes/Cell.gd"

func modulate_color(new_color_index):
	color_index = new_color_index
	var color = Globals.colors[color_index]
	$Sprite.modulate = color

func die():
	queue_free()

func move_to(tween, new_position):
	var current_position = global_position
	tween.interpolate_property(self, "global_position",
		current_position, new_position, Globals.get_time_interval(),
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#$Tween.start()
	return current_position
