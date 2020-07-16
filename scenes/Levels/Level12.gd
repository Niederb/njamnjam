extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_colors = 3
	Globals.level_config.n_goodies = 3
	Globals.level_config.map_name = "MarinaMap"
	level_number = 12
	$WinCondition.config.remove_all_blocks = true
	start_game()

func get_success_text():
	return "Campaign finished. \n !!Congratulations!! \n Going back to main menu..."

func get_tutorial_text():
	return "Removing black blocks\n\nRemove the black block by using the separators."
