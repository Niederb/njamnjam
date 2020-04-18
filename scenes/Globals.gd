extends Node

const CELL_SIZE: int = 64

var colors = [ Color(1, 0, 0), Color(0, 1, 0), Color(0, 0, 1), Color(0, 1, 1), Color(1, 0, 1), Color(1, 1, 0)]
const LEVEL_SIZE = Vector2(21, 13)
const NUMBER_OF_LEVELS = 6

enum CellType { WALL, GOODIE, SNAKE, EMPTY }

var score: int = 0
var level_config
var level_scene: String
	
func _ready():
	var level_config_class = preload("LevelConfig.gd")
	level_config = level_config_class.new()
	score = 0

func change_level(new_scene: String):
	var level_config_class = preload("LevelConfig.gd")
	level_config = level_config_class.new()
	level_scene = new_scene
	change_scene(new_scene)

func change_scene(new_scene: String):
	score = 0
	get_tree().change_scene(new_scene)

func get_scene(level_number):
	if level_number > NUMBER_OF_LEVELS:
		return "res://scenes/MainMenu.tscn"
	else:
		return "res://scenes/Levels/Level%s.tscn" % (level_number)
