extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.map_name = "MarinaMap"
	level_number = 4
	Globals.level_config.n_colors = 3
	$WinCondition.config.combo_count = 3
	start_game()

func get_tutorial_text():
	return "Different colors\n\nEat goodies with different colors in the right order to trigger combos"
