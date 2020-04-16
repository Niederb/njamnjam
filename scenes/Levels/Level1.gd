extends "res://scenes/GameState.gd"

func _ready():
	set_win_condition(2)
	load_map("FourPillarsMap")
	level_number = 1
