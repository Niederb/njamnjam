extends Node

class WinConfiguration:
	var snake_length: int = 0
	var score: int = 0
	var combo_count: int = 0
	
	func no_goal():
		return snake_length == 0 and score == 0 and combo_count == 0

var config: WinConfiguration = WinConfiguration.new()

func get_introduction_text() -> String:
	if config.snake_length > 0:
		return "Create a snake with %s blocks to beat the level" % config.snake_length 
	elif config.score > 0:
		return "Score %s points" % config.score
	elif config.combo_count > 0:
		return "Trigger %s combos" % config.combo_count
	return "Collect as many points as possible!"

func check_win() -> bool:
	if config.no_goal():
		return false
	var snake_length = get_parent().get_node("Player").length >= config.snake_length;
	var score = Globals.score >= config.score;
	var combo = get_parent().combo_count >= config.combo_count;
	return snake_length and score and combo
