extends Node

const START_LENGTH = 0
const CELL_SIZE = 64
var N_COLORS = 3
const N_GOODIES = 3
var MIN_COMBO_SIZE = 3
const TIME_INTERVAL = 0.25
var colors = [ Color(1, 0, 0), Color(0, 1, 0), Color(0, 0, 1), Color(0, 1, 1), Color(1, 0, 1), Color(1, 1, 0)]

enum CellType { WALL, GOODIE, SNAKE, EMPTY }

var score = 0

func _ready():
	score = 0