extends "res://scenes/GameState.gd"

func _ready():
	$WinCondition.config.score = 1000000000000000000
	start_game()
	
func get_scene(level_number):
	return "res://scenes/Levels/IndividualGame.tscn"
