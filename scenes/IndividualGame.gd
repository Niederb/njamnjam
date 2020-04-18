extends Control

func _on_MainMenuButton_pressed():
	Globals.change_scene("res://scenes/MainMenu.tscn")

func _on_StartButton_pressed():
	$CenterContainer/VBoxContainer/Options.apply()
	Globals.change_level("res://scenes/Levels/IndividualGameLevel.tscn")
