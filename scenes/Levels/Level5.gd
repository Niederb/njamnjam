extends "res://scenes/LevelTemplate.gd"

func _ready():
	load_map("RoomMap")
	level_number = 5
	Globals.level_config.n_goodies = 0
	$WinCondition.config.combo_count = 2
	start_game()


func get_tutorial_text():
	return "Square blocks cannot be collected, but they can be part of a combo"
