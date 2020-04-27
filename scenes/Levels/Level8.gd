extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 3
	Globals.level_config.n_goodies = 3
	load_map("FourPillarsMap")
	level_number = 8
	$WinCondition.config.score = 500
	start_game()

func get_tutorial_text():
	return "Avoid the moving blocks!"
