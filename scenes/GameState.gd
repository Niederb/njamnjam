extends Node2D
	
func _ready():
	add_to_group("Gamestate")
	for _i in range(Globals.N_GOODIES):
		add_goodie()

func add_goodie():
	var position = get_valid_position()
	$Goodies.create_new_goodie(position)

func get_valid_position():
	randomize()
	var space_state = get_world_2d().get_direct_space_state()
	while (true):
		var x = randi() % 19 + 1.5
		var y = randi() % 12 + 1.5
		var position = Vector2(Globals.CELL_SIZE * x, Globals.CELL_SIZE * y)
		var intersection = space_state.intersect_point(position)
		if !intersection:
			return position
	return Vector2()

func find_sub_graph(cell, cells, graph_index, graphs):
	for current_cell in cells:
		if !current_cell.processed():
			var distance = (current_cell.global_position - cell.global_position).length()
			if distance <= Globals.CELL_SIZE and current_cell.get_color_index() == cell.get_color_index():
				current_cell.sub_graph_id = graph_index
				graphs[graph_index].push_back(current_cell.id)
				find_sub_graph(current_cell, cells, graph_index, graphs)

func determine_sub_graphs(cells, min_size):
	var sub_graphs = []
	var id = 0
	for cell in cells:
		cell.reset(id)
		id += 1
		
	var graph_index = 0
	for cell in cells:
		if cell.processed():
			continue
		var graph = []
		sub_graphs.push_back(graph)
		sub_graphs[graph_index].push_back(cell.id)
		cell.sub_graph_id = graph_index
		
		find_sub_graph(cell, cells, graph_index, sub_graphs)
		graph_index += 1
	
	print("Subgraphs")
	print(sub_graphs)
	return sub_graphs

func get_adjacent_goodies(position, color_index, goodies):
	var adjacent = []
	for g in goodies:
		var distance = (g.global_position - position).length()
		var head_distance = ($Player/Head.global_position - position).length()
		if head_distance > Globals.CELL_SIZE and distance <= Globals.CELL_SIZE and g.get_color_index() == color_index and g.is_active():
			adjacent.push_back(g)
	return adjacent

func check_combo():
	var combo_size = 0
	var old_color_index = -1
	var start_index = 0
	var index = 0
	var sequential_body_parts = 0
	
	var body_parts = $Player.get_body_parts()
	var all_goodies = $Goodies.get_current_goodies()
	var cells = body_parts + all_goodies
	var sub_graphs = determine_sub_graphs(cells, Globals.MIN_COMBO_SIZE)
	for graph in sub_graphs:
		if graph.size() >= Globals.MIN_COMBO_SIZE:
			$Player.remove_body_parts(graph)
			var n_goodies = 0
			var n_body_parts = 0
			for cell_index in graph:
				var cell = cells[cell_index]
				if cell_index >= body_parts.size():
					n_goodies += 1
					cell.die()
					add_goodie()
				else:
					n_body_parts += 1
			trigger_combo(n_body_parts, n_goodies)

func eaten_goodie(color):
	$"/root/Globals".score += 10
	$Player.increase_length(color)
	add_goodie()
	$GUI.update_score($"/root/Globals".score)

func trigger_combo(n_body_parts, n_goodies):
	$"/root/Globals".score += 10 * n_body_parts * (n_goodies + 1)
	$GUI.update_score($"/root/Globals".score)

func _physics_process(_delta):
	if $Player.move_finished():
		check_combo()
	$Player.move()
	$GUI.update_fps()

func game_over():
	get_tree().change_scene("res://scenes/GameOver.tscn")
