extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 3
	Globals.level_config.n_goodies = 0
	Globals.level_config.map_name = "RectangleMap"
	level_number = 13
	$WinCondition.config.remove_all_blocks = true
	start_game()

