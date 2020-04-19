extends Control

func _on_Campaign_pressed():
	Globals.change_level("res://scenes/LevelSelection.tscn")

func _on_IndividualGame_pressed():
	Globals.change_level("res://scenes/IndividualGame.tscn")

func _on_Exit_pressed():
	get_tree().quit(0)
