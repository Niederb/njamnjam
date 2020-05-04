extends Control

func update_score(score):
	$VBoxContainer/HBoxContainer/Score.text = str(score)
	
func update_fps():
	$VBoxContainer/HBoxContainer2/FPS.set_text(str(Engine.get_frames_per_second()))
