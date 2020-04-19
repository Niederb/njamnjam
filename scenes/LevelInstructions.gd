extends VBoxContainer

const WAIT_COUNT_DOWN: int  = 3
var count_down: int = WAIT_COUNT_DOWN

func _ready():
	$CountdownLabel.text = str(count_down)

func show_level_start(level_name, introduction_text, tutorial_text):
	$LevelLabel.text = level_name
	$GoalLabel.text = introduction_text
	$TutorialLabel.text = tutorial_text
	$CountdownTimer.start()
	visible = true

func show_text(text):
	$GoalLabel.text = text
	$CountdownLabel.visible = false
	$TutorialLabel.visible = false
	visible = true

func _on_CountdownTimer_timeout():
	if count_down == 0:
		$CountdownTimer.stop()
		$StartSFX.play()
		count_down = WAIT_COUNT_DOWN
		visible = false
	else:
		count_down -= 1
		$CountdownSFX.play()
	$CountdownLabel.text = str(count_down)
	get_tree().call_group("Gamestate", "start_movement")
