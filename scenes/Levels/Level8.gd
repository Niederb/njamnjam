extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 1
	Globals.level_config.n_goodies = 000000
	Globals.level_config.min_combo_size = 5
	Globals.level_config.start_length = 4
	load_map("FourPillarsMap")
	level_number = 8
	$WinCondition.config.score = 500
	start_game()

func get_tutorial_text():
	return "Avoid the moving blocks!"

func get_success_text():
	return "Campaign finished. \n !!Congratulations!! \n Going back to main menu..."
