extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 3
	Globals.level_config.n_goodies = 0
	Globals.level_config.map_name = "RectangleMap"
	Globals.level_config.initial_body_parts = [3, 2, 2, 3]
	level_number = 14
	$WinCondition.config.multi_combo_count = 1
	start_game()

func get_success_text():
	return "Campaign finished. \n Congratulations! \n Going back to main menu..."


func get_tutorial_title():
	return "Multi-combos"

func get_tutorial_text():
	return "A multi combo is when you trigger multiple combos at the exact same time."
