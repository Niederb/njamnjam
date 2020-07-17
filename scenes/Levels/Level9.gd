extends "res://scenes/LevelTemplate.gd"

func _ready():
	Globals.level_config.n_goodies = 0
	level_number = 9
	$WinCondition.config.remove_all_blocks = true
	start_game()

func get_tutorial_title():
	return "Numbered blocks"

func get_tutorial_text():
	return "For some blocks you need bigger combos to destroy them. The number on the block tells you how big the combo needs to be."
