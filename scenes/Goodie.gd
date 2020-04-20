extends "res://scenes/Cell.gd"

func _ready():
	if color_index != -1:
		update_color()

func init(position, new_color_index):
	color_index = new_color_index
	update_color()
	self.position = position
	$AnimationPlayer.play()
	
func update_color():
	var color = Globals.colors[color_index]
	$Sprite.modulate = color
	$Light.color = color
	
func _on_Area2D_body_entered(_body):
	if active:
		get_tree().call_group("Gamestate", "eaten_goodie", color_index)
		active = false
		$Sprite.visible = false
		die()

func die():
	queue_free()
