extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.map_name = "TwoHMap"
	level_number = 3
	Globals.level_config.n_colors = 1
	Globals.level_config.n_goodies = 0
	$WinCondition.config.combo_count = 2
	start_game()

func get_tutorial_text():
	return "Combos II\n\nCombos can be triggered by having multiple elements with the same color next to each other."
