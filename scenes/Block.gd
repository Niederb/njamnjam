extends "res://scenes/Cell.gd"

export var min_combo_size = 3

func modulate_color(new_color_index):
	color_index = new_color_index
	if min_combo_size > 3:
		$Label.text = str(min_combo_size)
	apply_color()
	
func apply_color():
	if color_index >= 0:
		var color = Globals.get_gameplay_color(color_index)
		$Sprite.self_modulate = color
		#$Sprite.modulate = color
		$Light.color = color
	else:
		$Light.enabled = false
	if min_combo_size > 3:
		$Label.text = str(min_combo_size)

func die():
	queue_free()

func verify_combo(combo_elements) -> bool:
	return combo_elements.size() >= min_combo_size
