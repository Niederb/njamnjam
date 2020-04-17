extends "res://scenes/LevelTemplate.gd"

func _ready():
	load_map("DiagonalPillarsMap")
	level_number = 2
	#$WinCondition.config.snake_length = 3
	$WinCondition.config.combo_count = 2
	start_game()
