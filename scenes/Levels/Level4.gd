extends "res://scenes/LevelTemplate.gd"

func _ready():
	load_map("MarinaMap")
	level_number = 4
	Globals.level_config.n_colors = 1
	$WinCondition.config.combo_count = 3
	start_game()
