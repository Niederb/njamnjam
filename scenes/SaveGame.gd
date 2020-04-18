extends Node

var data = {}

func set_reached_level(level: int) -> void:
	data["reached_level"] = level

func set_high_score(high_score: int) -> void:
	data["high_score"] = high_score

func get_reached_level() -> int:
	if data.has("reached_level"):
		return data["reached_level"]
	return 0

func get_high_score() -> int:
	if data.has("high_score"):
		return data["high_score"]
	return 0

func save():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(data))
	save_game.close()

func load_save_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	save_game.open("user://savegame.save", File.READ)
	
	data = parse_json(save_game.get_line())
	save_game.close()
