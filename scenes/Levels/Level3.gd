extends "res://scenes/GameState.gd"

func _ready():
	load_map("TwoHMap")
	level_number = 3
	Globals.level_config.n_goodies = 0
	$WinCondition.config.combo_count = 2
	start_game()
