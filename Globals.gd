extends Node

const START_LENGTH = 0
const CELL_SIZE = 32
const N_COLORS = 3
const N_GOODIES = 3
const MIN_COMBO_SIZE = 3
const TIME_INTERVAL = 0.25
var colors = [ Color(1, 0, 0), Color(0, 1, 0), Color(0, 0, 1), Color(0, 1, 1)]

enum CellType { WALL, GOODIE, SNAKE, EMPTY }
