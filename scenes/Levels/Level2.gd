extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.map_name = "DiagonalPillarsMap"
	level_number = 2
	Globals.level_config.n_colors = 1
	$WinCondition.config.combo_count = 2
	start_game()

func get_tutorial_text():
	return "Combos\n\nIf your snake has three body parts of the same color it will trigger a combo and the body parts will disappear"
