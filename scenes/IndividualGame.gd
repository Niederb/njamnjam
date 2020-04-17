extends Control



func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_StartButton_pressed():
	$CenterContainer/VBoxContainer/Options.apply()
	get_tree().change_scene("res://scenes/Levels/IndividualGame.tscn")
