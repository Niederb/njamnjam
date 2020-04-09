extends Node2D

var taken = false
var color_index = 0

func init(position, new_color_index):
	color_index = new_color_index
	var color = Globals.colors[color_index]
	global_position = position
	$Sprite.modulate = color
	$Light.color = color
	
func _on_Area2D_body_entered(body):
	if not taken:
		get_tree().call_group("Gamestate", "eaten_goodie", color_index)
		taken = true
		$Sprite.visible = false
		queue_free()
