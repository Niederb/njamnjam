extends "res://scenes/GameState.gd"

func _ready():
	$WinCondition.min_length = 3
	level_number = 2
