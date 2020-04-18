extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 1
	load_map("FourPillarsMap")
	level_number = 1
	$WinCondition.config.snake_length = 2
	start_game()

func get_tutorial_text():
	return "Collect the round goodies to make your snake longer"
