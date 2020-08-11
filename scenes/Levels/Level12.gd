extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 3
	Globals.level_config.n_goodies = 5
	Globals.level_config.map_name = "MarinaMap"
	level_number = 12
	$WinCondition.config.remove_all_blocks = true
	start_game()

func get_tutorial_title():
	return "Removing black blocks"

func get_tutorial_text():
	return "Remove the black block by using the separators."
