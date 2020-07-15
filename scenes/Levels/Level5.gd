extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.map_name = "RoomMap"
	level_number = 5
	Globals.level_config.n_goodies = 0
	$WinCondition.config.combo_count = 2
	start_game()

func get_tutorial_text():
	return "Blocks\n\nYou cannot eat square blocks, but you can remove them by making them part of a combo."
