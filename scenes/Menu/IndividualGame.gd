extends Control

func _ready():
	$BackgroundPanel/VBoxContainer/HBoxContainer2/HighScore.text = str(Globals.save_game.get_high_score())
	
func _on_MainMenuButton_pressed():
	Globals.change_scene("res://scenes/Menu/MainMenu.tscn")

func _on_StartButton_pressed():
	$BackgroundPanel/VBoxContainer/Options.apply()
	Globals.change_scene("res://scenes/Levels/IndividualGameLevel.tscn")
