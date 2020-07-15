extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.map_name = "ChannelStartMap"
	Globals.level_config.movement_speed = 4
	Globals.level_config.n_goodies = 0
	Globals.level_config.n_colors = 2
	
	level_number = 11
	$WinCondition.config.remove_all_blocks = true
	start_game()

func get_tutorial_text():
	return "Separators\n\nEat goodies with different colors in the right order to trigger combos"
