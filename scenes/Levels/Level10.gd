extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.map_name = ""
	Globals.level_config.movement_speed = 4
	Globals.level_config.n_goodies = 0
	Globals.level_config.n_colors = 2
	level_number = 10
	$WinCondition.config.combo_count = 3
	start_game()

func get_success_text():
	return "Campaign finished. \n !!Congratulations!! \n Going back to main menu..."
