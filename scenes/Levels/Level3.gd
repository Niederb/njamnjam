extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.map_name = "TwoHMap"
	level_number = 3
	Globals.level_config.n_colors = 1
	Globals.level_config.n_goodies = 0
	$WinCondition.config.combo_count = 2
	start_game()

func get_tutorial_title():
	return "Combos II"

func get_tutorial_text():
	return "You can use the goodies in a combo without eating them. Just move alongside a goodie and if you line it up with your body parts you can trigger a combo."
