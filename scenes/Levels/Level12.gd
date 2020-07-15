extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 3
	Globals.level_config.n_goodies = 3
	Globals.level_config.map_name = "FourPillarsMap"
	level_number = 12
	$WinCondition.config.score = 200
	start_game()

func get_success_text():
	return "Campaign finished. \n !!Congratulations!! \n Going back to main menu..."
