extends Control

const WAIT_COUNT_DOWN: int  = 3
var count_down: int = WAIT_COUNT_DOWN

func _ready():
	$TextContainer/CountdownLabel.text = str(count_down)

func show_level_start(level_name, introduction_text, tutorial_text):
	$TextContainer/LevelLabel.text = level_name
	$TextContainer/GoalLabel.text = introduction_text
	$TextContainer/TutorialLabel.text = tutorial_text
	$CountdownTimer.start()
	$AnimationPlayer.play("fade_in")
	visible = true

func show_text(text):
	$TextContainer/GoalLabel.text = text
	$TextContainer/CountdownLabel.visible = false
	$TextContainer/TutorialLabel.visible = false
	$AnimationPlayer.play("fade_in")#visible = true

func _on_CountdownTimer_timeout():
	if count_down == 0:
		$CountdownTimer.stop()
		$StartSFX.play()
		count_down = WAIT_COUNT_DOWN
		#visible = false
		get_tree().call_group("Gamestate", "start_movement")
		$AnimationPlayer.play_backwards("fade_in")
	else:
		count_down -= 1
		$CountdownSFX.play()
	$TextContainer/CountdownLabel.text = str(count_down)
