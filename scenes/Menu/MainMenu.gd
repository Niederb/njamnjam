extends Control

func _ready():
	$BackgroundPanel/VBoxContainer/Campaign.grab_focus()

func _on_Campaign_pressed():
	Globals.change_level("res://scenes/Menu/LevelSelection.tscn")

func _on_IndividualGame_pressed():
	Globals.change_level("res://scenes/Menu/IndividualGame.tscn")

func _on_Help_pressed():
	Globals.change_level("res://scenes/Menu/Help.tscn")
	
func _on_Credits_pressed():
	Globals.change_level("res://scenes/Menu/Credits.tscn")	

func _on_Exit_pressed():
	get_tree().quit(0)

func _on_TwoPlayer_pressed():
	Globals.change_level("res://scenes/Splitscreen.tscn")
