extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.map_name = "ChannelStartMap"
	level_number = 6
	Globals.level_config.n_goodies = 0
	Globals.level_config.start_cell = Vector2(1, 1)
	$WinCondition.config.remove_all_blocks = true
	start_game()
