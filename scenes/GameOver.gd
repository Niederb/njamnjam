extends Control

func _ready():
	$CenterContainer/VBoxContainer/HBoxContainer/FinalScore.text = str($"/root/Globals".score)

func _on_TryAgainButton_pressed():
	Globals.score = 0
	get_tree().change_scene("res://scenes/LevelTemplate.tscn")
