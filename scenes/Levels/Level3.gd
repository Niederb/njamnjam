extends "res://scenes/GameState.gd"

func _ready():
	level_number = 3
	$WinCondition.config.score = 100
	start_game()
