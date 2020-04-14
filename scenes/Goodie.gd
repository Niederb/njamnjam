extends "res://scenes/Cell.gd"

func init(position, new_color_index):
	color_index = new_color_index
	var color = Globals.colors[color_index]
	global_position = position
	$Sprite.modulate = color
	$Light.color = color
	$AnimationPlayer.play()
	
func _on_Area2D_body_entered(_body):
	if active:
		get_tree().call_group("Gamestate", "eaten_goodie", color_index)
		active = false
		$Sprite.visible = false
		die()

func die():
	queue_free()
