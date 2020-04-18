extends Control

func _ready():
	$CenterContainer/VBoxContainer/HBoxContainer/FinalScore.text = str(Globals.score)

func _on_TryAgainButton_pressed():
	Globals.change_scene(Globals.level_scene)

func _on_MainMenuButton_pressed():
	Globals.change_scene("res://scenes/MainMenu.tscn")
