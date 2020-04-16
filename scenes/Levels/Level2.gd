extends "res://scenes/GameState.gd"

func _ready():
	load_map("DiagonalPillarsMap")
	level_number = 2
	#$WinCondition.config.snake_length = 3
	$WinCondition.config.score = 50
	start_game()
