extends Node

const START_LENGTH = 0
const CELL_SIZE = 64
var N_COLORS = 3
var N_GOODIES = 3
var MIN_COMBO_SIZE = 3
var MOVEMENT_SPEED = 4
var colors = [ Color(1, 0, 0), Color(0, 1, 0), Color(0, 0, 1), Color(0, 1, 1), Color(1, 0, 1), Color(1, 1, 0)]
const LEVEL_SIZE = Vector2(21, 13)

enum CellType { WALL, GOODIE, SNAKE, EMPTY }

var score = 0

func _ready():
	score = 0

func get_time_interval():
	return 1.0 / MOVEMENT_SPEED
