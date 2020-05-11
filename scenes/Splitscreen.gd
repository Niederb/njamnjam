extends Node2D

func _ready():
	Globals.level_config.n_colors = 1
	Globals.level_config.map_name = "FourPillarsMap"
	#Globals.level_config.map_name = "FourPillarsMap"
	#level_number = 1
	#$WinCondition.config.snake_length = 2
	$LevelTemplate.start_game()
	$LevelTemplate2.start_game()
