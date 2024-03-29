extends Node

enum WinStatus { CONTINUE = 0, FAILED = -1, SUCCESS = 1 }

class WinConfiguration:
	var snake_length: int = 0
	var score: int = 0
	var combo_count: int = 0
	var multi_combo_count: int = 0
	var remove_all_blocks: bool = false
	var zero_length: bool = false
	
	func no_goal():
		return snake_length == 0 and score == 0 and combo_count == 0 and multi_combo_count == 0 and remove_all_blocks == false and zero_length == false

var config: WinConfiguration = WinConfiguration.new()

func get_introduction_text() -> String:
	if config.snake_length > 0:
		return "Create a snake of length %s to beat the level" % config.snake_length 
	elif config.score > 0:
		return "Score %s points" % config.score
	elif config.combo_count > 0:
		return "Trigger %s combos" % config.combo_count
	elif config.multi_combo_count > 0:
		return "Trigger %s multi-combos" % config.multi_combo_count
	elif config.remove_all_blocks:
		return "Remove all blocks"
	elif config.zero_length:
		return "Reduce the snake lenght to zero"
	return "Collect as many points as possible!"

func check_win(player) -> int:
	if config.no_goal():
		return WinStatus.CONTINUE
	var snake_length = player.get_length() >= config.snake_length;
	var score = player.score >= config.score;
	var combo = player.combo_count >= config.combo_count;
	var multi_combo = player.multi_combo_count >= config.multi_combo_count;
	var remove_blocks = true
	if config.remove_all_blocks:
		remove_blocks = get_parent().get_node("Blocks").get_child_count() == 0
	var zero_length = true
	if config.zero_length:
		remove_blocks = player.get_length() == 0
	if snake_length and score and combo and multi_combo and remove_blocks and zero_length:
		return WinStatus.SUCCESS
	return WinStatus.CONTINUE
