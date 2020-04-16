extends "res://scenes/GameState.gd"

func _ready():
	$WinCondition.min_length = 5
	level_number = 3
