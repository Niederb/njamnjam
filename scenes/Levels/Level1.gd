extends "res://scenes/GameState.gd"

func _ready():
	$WinCondition.min_length = 1
	level_number = 1
