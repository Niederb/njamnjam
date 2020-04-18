extends "res://scenes/LevelTemplate.gd"

func _ready():
	load_map("DiagonalPillarsMap")
	level_number = 2
	Globals.level_config.n_colors = 1
	$WinCondition.config.combo_count = 2
	start_game()

func get_tutorial_text():
	return "If your snake has three parts of the same color it will trigger a combo and the parts will disappear"
