extends Control

func _ready():
	$BackgroundPanel/VBoxContainer/MainMenuButton.grab_focus()

func _on_MainMenuButton_pressed():
	Globals.change_scene("res://scenes/Menu/MainMenu.tscn")
