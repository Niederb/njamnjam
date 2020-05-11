extends "res://scenes/Cell.gd"

var level_instance

func _ready():
	if color_index != -1:
		update_color()

func init(position, new_color_index, level_instance):
	color_index = new_color_index
	update_color()
	self.position = position
	self.level_instance = level_instance
	$AnimationPlayer.play()
	
func update_color():
	var color = Globals.get_gameplay_color(color_index)
	$Sprite.modulate = color
	$Light.color = color
	
func _on_Area2D_area_entered(area):
	if active and area.collision_layer == 1:
		get_tree().call_group(level_instance, "eaten_goodie", color_index)
		active = false
		$Sprite.visible = false
		die()

func die():
	queue_free()
