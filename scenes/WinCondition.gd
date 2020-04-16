extends Node

class WinConfiguration:
	var snake_length = 0
	var score = 0
	var combo_count = 0

var config: WinConfiguration = WinConfiguration.new()

func get_introduction_text():
	if config.snake_length > 0:
		return "Create a snake with %s blocks to beat the level" % config.snake_length 
	elif config.score > 0:
		return "Score %s points" % config.score
	return "Collect as many points as possible!"

func check_win():
	var snake_length = get_parent().get_node("Player").length >= config.snake_length;
	var score = Globals.score >= config.score;
	return snake_length and score
