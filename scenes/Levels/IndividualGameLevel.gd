extends "res://scenes/LevelTemplate.gd"

func _ready():
	$WinCondition.config.score = 0
	start_game()
	
func get_scene(level_number):
	return "res://scenes/Levels/IndividualGameLevel.tscn"

func get_level_name():
	return "Individual game"
