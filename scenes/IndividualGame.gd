extends Control

func _ready():
	$CenterContainer/VBoxContainer/HBoxContainer2/HighScore.text = str(Globals.save_game.get_high_score())
	
func _on_MainMenuButton_pressed():
	Globals.change_scene("res://scenes/Menu/MainMenu.tscn")

func _on_StartButton_pressed():
	$CenterContainer/VBoxContainer/Options.apply()
	Globals.change_scene("res://scenes/Levels/IndividualGameLevel.tscn")
