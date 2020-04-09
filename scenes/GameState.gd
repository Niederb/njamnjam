extends Node2D

var score = 0

func _ready():
	add_to_group("Gamestate")
	for i in range(Globals.N_GOODIES):
		$Goodies.create_new_goodie()

func eaten_goodie(color):
	score += 10
	$Player.increase_length(color)
	$Goodies.create_new_goodie()
	$GUI.update_score(score)

func trigger_combo(combo_size):
	score += 10 * combo_size
	$GUI.update_score(score)

func set_cell_type(position, cell_type):
	var target_cell = $TileMap.world_to_map(position)
	$TileMap.set_cellv(target_cell, cell_type)
