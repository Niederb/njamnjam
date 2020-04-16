extends Control



func _on_Campaign_pressed():
	get_tree().change_scene("res://scenes/Levels/Level1.tscn")


func _on_IndividualGame_pressed():
	get_tree().change_scene("res://scenes/IndividualGame.tscn")
