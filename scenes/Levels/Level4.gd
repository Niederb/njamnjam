extends "res://scenes/LevelTemplate.gd"

func _ready():
	load_map("MarinaMap")
	level_number = 4
	Globals.level_config.n_colors = 3
	$WinCondition.config.combo_count = 3
	start_game()

func get_tutorial_text():
	return "Multiple colors need to be collected in the right order to trigger combos"
