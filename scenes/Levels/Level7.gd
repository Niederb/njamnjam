extends "res://scenes/LevelTemplate.gd"

func _ready():
	load_map("FourPillarsMap")
	level_number = 7
	Globals.level_config.n_goodies = 3
	#Globals.level_config.start_cell = Vector2(1, 1)
	$WinCondition.config.zero_length = true
	start_game()

