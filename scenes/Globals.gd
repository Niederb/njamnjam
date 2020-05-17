extends Node

const CELL_SIZE: int = 64

var gameplay_color_offset: int = 1
var color_palettes = { 
	"bright": [ Color(0, 0, 0), Color(1, 0, 0), Color(0, 1, 0), Color(0, 0, 1), Color(0, 1, 1), Color(1, 0, 1), Color(1, 1, 0)], 
	"pastel": [ Color(0, 0, 0), Color("AA3939"), Color("29506D"), Color("91A437"), Color(0, 1, 1), Color(1, 0, 1), Color(1, 1, 0)]
	}

var current_color_palette = color_palettes["pastel"]
const LEVEL_SIZE = Vector2(21, 13)
const NUMBER_OF_LEVELS = 10

var level_config
var save_game
var level_scene: String
	
func _ready():
	var level_config_class = preload("LevelConfig.gd")
	level_config = level_config_class.new()
	
	var save_game_class = preload("SaveGame.gd")
	save_game = save_game_class.new()
	save_game.load_save_game()

func change_level(new_scene: String):
	var level_config_class = preload("LevelConfig.gd")
	level_config = level_config_class.new()
	level_scene = new_scene
	change_scene(new_scene)

func change_scene(new_scene: String):
	get_tree().change_scene(new_scene)

func get_scene(level_number):
	if level_number > NUMBER_OF_LEVELS:
		return "res://scenes/Menu/MainMenu.tscn"
	else:
		return "res://scenes/Levels/Level%s.tscn" % (level_number)

func get_number_gameplay_colors():
	return current_color_palette.size() - gameplay_color_offset

func get_random_color_index():
	return gameplay_color_offset + randi() % level_config.n_colors

func get_gameplay_color(color_index: int) -> Color:
	return current_color_palette[color_index]
