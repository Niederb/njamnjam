extends Control

func _ready():
	$CenterContainer/VBoxContainer/HBoxContainer/FinalScore.text = str(0)

func _on_TryAgainButton_pressed():
	Globals.change_scene(Globals.level_scene)

func _on_MainMenuButton_pressed():
	Globals.change_scene("res://scenes/Menu/MainMenu.tscn")
