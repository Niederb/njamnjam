extends Node

var goodies = []

func get_adjacent_goodies(position, color):
	var goodies = []
	for g in get_children():
		if (g.global_position - position).length() < Globals.CELL_SIZE:
			goodies.push_back(g)
			
	return goodies
	
func create_new_goodie():
	var body_part = load("res://scenes/Goodie.tscn").instance()
	add_child(body_part)
	randomize()
	var x = randi() % 19 + 1
	var y = randi() % 12 + 1
	var color_index = randi() % Globals.N_COLORS
	
	var position = Vector2(Globals.CELL_SIZE * x, Globals.CELL_SIZE * y)
	body_part.init(position, color_index)
