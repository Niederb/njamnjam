extends Node

const CELL_SIZE: int = 64

#var colors = [ Color(1, 0, 0), Color(0, 1, 0), Color(0, 0, 1), Color(0, 1, 1), Color(1, 0, 1), Color(1, 1, 0)]
var colors = [ Color("AA3939"), Color("29506D"), Color("91A437"), Color(0, 1, 1), Color(1, 0, 1), Color(1, 1, 0)]
const LEVEL_SIZE = Vector2(21, 13)
const NUMBER_OF_LEVELS = 10

var score: int = 0
var level_config
var save_game
var level_scene: String
	
func _ready():
	var level_config_class = preload("LevelConfig.gd")
	level_config = level_config_class.new()
	
	var save_game_class = preload("SaveGame.gd")
	save_game = save_game_class.new()
	save_game.load_save_game()
	score = 0

func change_level(new_scene: String):
	score = 0
	var level_config_class = preload("LevelConfig.gd")
	level_config = level_config_class.new()
	level_scene = new_scene
	change_scene(new_scene)

func change_scene(new_scene: String):
	get_tree().change_scene(new_scene)

func get_scene(level_number):
	if level_number > NUMBER_OF_LEVELS:
		return "res://scenes/MainMenu.tscn"
	else:
		return "res://scenes/Levels/Level%s.tscn" % (level_number)

func set_new_score(score: int) -> void:
	if score > save_game.get_high_score():
		save_game.set_high_score(score)
		save_game.save()

func set_reached_leve(level: int) -> void:
	if level > save_game.get_reached_level():
		save_game.set_reached_leve(level)
		save_game.save()

func get_random_color_index():
	return randi() % level_config.n_colors
