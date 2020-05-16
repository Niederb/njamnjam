extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 1
	Globals.level_config.map_name = "FourPillarsMap"
	level_number = 1
	$WinCondition.config.snake_length = 2
	start_game()

func get_tutorial_text():
	return "Collecting goodies\n\nCollect the round goodies to make your snake longer"
