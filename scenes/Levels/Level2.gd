extends "res://scenes/GameState.gd"

func _ready():
	set_win_condition(3)
	load_map("DiagonalPillarsMap")
	level_number = 2
