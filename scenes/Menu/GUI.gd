extends Control

func _ready():
	update_separator_action(0)

func update_score(score):
	$HBoxContainer/GridContainer/Score.text = str(score)
	
func update_fps():
	$HBoxContainer/GridContainer/FPS.set_text(str(Engine.get_frames_per_second()))

func pause(paused: bool):
	var text = ""
	if paused:
		text = "Paused"
	$HBoxContainer/GridContainer/Status.text = text

func update_separator_action(number: int):
	$HBoxContainer/GridContainer/SeparatorCounter.clear()
	for b in range(number):
		$HBoxContainer/GridContainer/SeparatorCounter.add_icon_item(load("res://gfx/block.png"), false)
