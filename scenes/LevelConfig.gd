extends Node

var n_colors: int = 3
var n_goodies: int = 3
var min_combo_size: int = 3
var movement_speed: float = 4.0
var start_cell := Vector2()

func get_time_interval():
	return 1.0 / movement_speed
