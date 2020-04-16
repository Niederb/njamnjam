extends "res://scenes/GameState.gd"

func _ready():

	load_map("FourPillarsMap")
	level_number = 1
	$WinCondition.config.snake_length = 2
	start_game()
