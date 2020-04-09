extends Node2D

var score = 0

func _ready():
	add_to_group("Gamestate")
	for i in range(Globals.N_GOODIES):
		var position = get_valid_position()
		$Goodies.create_new_goodie(position)

func get_valid_position():
	randomize()
	var space_state = get_world_2d().get_direct_space_state()
	var tries = 0
	while (true):
		var x = randi() % 19 + 1.5
		var y = randi() % 12 + 1.5
		var position = Vector2(Globals.CELL_SIZE * x, Globals.CELL_SIZE * y)
		var intersection = space_state.intersect_point(position)
		tries += 1
		if !intersection:
			if tries > 1:
				print("Used multiple tries: %s" % tries)
			return position
	return Vector2()

func eaten_goodie(color):
	score += 10
	$Player.increase_length(color)
	var position = get_valid_position()
	$Goodies.create_new_goodie(position)
	$GUI.update_score(score)

func trigger_combo(combo_size):
	score += 10 * combo_size
	$GUI.update_score(score)

func set_cell_type(position, cell_type):
	var target_cell = $TileMap.world_to_map(position)
	$TileMap.set_cellv(target_cell, cell_type)

func _on_Timer_timeout():
	$Player.move_again()
