extends Node2D

var level_number
	
func _ready():
	add_to_group("Gamestate")
	for _i in range(Globals.N_GOODIES):
		add_goodie()
	randomize_blocks()

func randomize_blocks():
	for b in $Blocks.get_children():
		var color_index = randi() % Globals.N_COLORS
		b.modulate_color(color_index)

func add_goodie():
	var position = get_valid_position()
	$Goodies.create_new_goodie(position)

func head_distance(point):
	return ($Player/Head.global_position - point).length()
	
func get_valid_position():
	randomize()
	var space_state = get_world_2d().get_direct_space_state()
	while (true):
		var x = randi() % int(Globals.LEVEL_SIZE.x) + 0.5
		var y = randi() % int(Globals.LEVEL_SIZE.y) + 0.5
		var position = Vector2(Globals.CELL_SIZE * x, Globals.CELL_SIZE * y)
		var intersection = space_state.intersect_point(position)
		if !intersection and head_distance(position) > 2*Globals.CELL_SIZE:
			return position
	return Vector2()

func find_sub_graph(cell, cells, graph_index, graphs):
	for current_cell in cells:
		if !current_cell.processed():
			var distance = (current_cell.global_position - cell.global_position).length()
			if head_distance(current_cell.global_position) > Globals.CELL_SIZE and distance <= Globals.CELL_SIZE and current_cell.get_color_index() == cell.get_color_index():
				current_cell.sub_graph_id = graph_index
				graphs[graph_index].push_back(current_cell.id)
				find_sub_graph(current_cell, cells, graph_index, graphs)

func determine_sub_graphs(cells):
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
		if head_distance(position) > Globals.CELL_SIZE and distance <= Globals.CELL_SIZE and g.get_color_index() == color_index and g.is_active():
			adjacent.push_back(g)
	return adjacent

func check_combo():
	var body_parts = $Player.get_body_parts()
	var all_goodies = $Goodies.get_current_goodies()
	var all_blocks = $Blocks.get_children()
	var cells = body_parts + all_goodies + all_blocks
	var sub_graphs = determine_sub_graphs(cells)
	for graph in sub_graphs:
		if graph.size() >= Globals.MIN_COMBO_SIZE:
			$Player.remove_body_parts(graph)
			var n_goodies = 0
			var n_body_parts = 0
			var n_blocks = 0
			for cell_index in graph:
				var cell = cells[cell_index]
				if cell_index < body_parts.size():
					n_body_parts += 1
				elif cell_index < (body_parts.size() + all_goodies.size()):
					n_goodies += 1
					cell.die()
					add_goodie()
				else:
					n_blocks += 1
					cell.die()
					
			trigger_combo(n_body_parts, n_goodies)

func eaten_goodie(color):
	Globals.score += 10
	$Player.increase_length(color)
	add_goodie()
	$GUI.update_score(Globals.score)

func trigger_combo(n_body_parts, n_goodies):
	Globals.score += 10 * n_body_parts * (n_goodies + 1)
	$GUI.update_score(Globals.score)
	$ComboSFX.play()

func _physics_process(_delta):
	if $Player.move_finished():
		check_combo()
	$Player.move()
	$GUI.update_fps()
	if $WinCondition.check_win():
		var next_scene = get_next_scene()
		#var scene = load(next_scene)
		get_tree().change_scene(next_scene)
		
func game_over():
	get_tree().change_scene("res://scenes/GameOver.tscn")

func get_next_scene():
	return "res://scenes/levels/Level%s.tscn" % (level_number + 1)
