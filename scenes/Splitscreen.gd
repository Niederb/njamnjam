extends Node2D

func _ready():
	Globals.level_config.n_colors = 1
	$LevelTemplate.load_map("FourPillarsMap")
	$LevelTemplate2.load_map("FourPillarsMap")
	#level_number = 1
	#$WinCondition.config.snake_length = 2
	$LevelTemplate.start_game()
	$LevelTemplate2.start_game()
