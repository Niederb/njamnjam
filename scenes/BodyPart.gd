extends "res://scenes/Cell.gd"

func _ready():
	$CollisionShape2D.disabled = true
	$Timer.start()

func initialize(position, new_color_index):
	self.position = position
	color_index = new_color_index
	var color = Globals.colors[color_index]
	$Sprite.modulate = color

func die():
	queue_free()

func move_to(tween, new_position):
	var current_position = self.position
	tween.interpolate_property(self, "position",
		current_position, new_position, Globals.level_config.get_time_interval(),
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	return current_position


func _on_Timer_timeout():
	$CollisionShape2D.disabled = false
