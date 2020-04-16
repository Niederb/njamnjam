extends Node

const START_LENGTH = 0
const CELL_SIZE = 64

var colors = [ Color(1, 0, 0), Color(0, 1, 0), Color(0, 0, 1), Color(0, 1, 1), Color(1, 0, 1), Color(1, 1, 0)]
const LEVEL_SIZE = Vector2(21, 13)

enum CellType { WALL, GOODIE, SNAKE, EMPTY }

var score = 0
var level_config
var level_scene: String
	
func _ready():
	var level_config_class = preload("LevelConfig.gd")
	level_config = level_config_class.new()
	score = 0


