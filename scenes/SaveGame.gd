extends Node

var data = {}

func set_reached_level(level: int) -> void:
	if (data.has("reached_level") and data["reached_level"] >= level):
		return
	if level > Globals.NUMBER_OF_LEVELS:
		return
	data["reached_level"] = level
	save()

func verify_high_score(score: int) -> bool:
	if score > get_high_score():
		data["high_score"] = score
		save()
		return true
	return false

func get_reached_level() -> int:
	if data.has("reached_level"):
		return data["reached_level"]
	return 1

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
