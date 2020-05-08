extends Control

func update_score(score):
	$HBoxContainer/GridContainer/Score.text = str(score)
	
func update_fps():
	$HBoxContainer/GridContainer/FPS.set_text(str(Engine.get_frames_per_second()))

func pause(paused: bool):
	var text = ""
	if paused:
		text = "Paused"
	$HBoxContainer/Status.text = text
