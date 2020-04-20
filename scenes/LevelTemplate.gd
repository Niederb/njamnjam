extends Node2D

var level_number: int
var level_defeated: bool = false
var pause_movement: bool = true
var combo_count: int = 0

func _ready():
	add_to_group("Gamestate")

func randomize_blocks() -> void:
	for b in $Blocks.get_children():
		if b.color_index == -1:
			var color_index = randi() % Globals.level_config.n_colors
			b.modulate_color(color_index)
		else:
			b.apply_color()

func add_goodie() -> void:
	if $Goodies.get_child_count() > Globals.level_config.n_goodies:
		return
	var position = get_valid_position()
	var color_index = randi() % Globals.level_config.n_colors
	$Goodies.create_new_goodie(position, color_index)

func head_distance(point) -> float:
	return $Players/Player/Head.position.distance_to(point)
	
func get_valid_position() -> Vector2:
	randomize()
	var space_state = get_world_2d().get_direct_space_state()
	var offset = Vector2(Globals.CELL_SIZE/2, Globals.CELL_SIZE/2)
	while (true):
		var x = randi() % int(Globals.LEVEL_SIZE.x)
		var y = randi() % int(Globals.LEVEL_SIZE.y)
		var position = Vector2(Globals.CELL_SIZE * x, Globals.CELL_SIZE * y)
		var intersection = space_state.intersect_point(position + offset)
		if !intersection and head_distance(position) > 2*Globals.CELL_SIZE:
			#print(position)
			return position
	return Vector2()

func find_sub_graph(cell, cells, graph_index, graphs):
	for current_cell in cells:
		if !current_cell.processed():
			var distance = (current_cell.position - cell.position).length()
			if head_distance(current_cell.position) > Globals.CELL_SIZE and distance <= Globals.CELL_SIZE and current_cell.get_color_index() == cell.get_color_index():
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
	return sub_graphs

func get_adjacent_goodies(position, color_index, goodies):
	var adjacent = []
	for g in goodies:
		var distance = (g.position - position).length()
		if head_distance(position) > Globals.CELL_SIZE and distance <= Globals.CELL_SIZE and g.get_color_index() == color_index and g.is_active():
			adjacent.push_back(g)
	return adjacent

func check_combo():
	var body_parts = $Players/Player.get_body_parts()
	var all_goodies = $Goodies.get_current_goodies()
	var all_blocks = $Blocks.get_children()
	var cells = body_parts + all_goodies + all_blocks
	var sub_graphs = determine_sub_graphs(cells)
	for graph in sub_graphs:
		if graph.size() >= Globals.level_config.min_combo_size:
			$Players/Player.remove_body_parts(graph)
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
	$Players/Player.increase_length(color)
	add_goodie()
	$HUD.update_score(Globals.score)

func trigger_combo(n_body_parts, n_goodies):
	Globals.score += 10 * n_body_parts * (n_goodies + 1)
	$HUD.update_score(Globals.score)
	$ComboSFX.play()
	combo_count += 1

func _physics_process(_delta):
	if pause_movement:
		$Players/Player.direction = Vector2()
		
	if $Players/Player.move_finished():
		check_combo()
	$Players/Player.move()
	$HUD.update_fps()
	if $WinCondition.check_win() == 1 and !level_defeated:
		Globals.score = 0
		level_defeated = true
		pause_movement = true
		var text = get_success_text()
		$LevelInstructions.show_text(text)
		$NextLevelTimer.start()
		
func game_over():
	$Players/Player.dead = true
	$LevelInstructions.show_text("Ooops :-( \n Try again!")
	if $NextLevelTimer.is_stopped():
		$NextLevelTimer.start()

func start_game():
	Globals.score = 0
	if Globals.level_config.start_cell.length() > 0:
		$Players/Player.position = Globals.CELL_SIZE * (Globals.level_config.start_cell + Vector2(0.5, 0.5))
	for _i in range(Globals.level_config.n_goodies):
		add_goodie()
	$Players/Player.init(Globals.level_config.start_length)
	randomize_blocks()
	var intro_text = $WinCondition.get_introduction_text()
	$LevelInstructions.show_level_start(get_level_name(), intro_text, get_tutorial_text())

func load_map(map_name):
	var new_map = load("res://scenes/Maps/%s.tscn" % map_name)
	var new_instance = new_map.instance()
	$Map.replace_by(new_instance)

func _on_NextLevelTimer_timeout():
	if level_defeated:
		if is_campaign_level():
			Globals.save_game.set_reached_level(level_number + 1)
			Globals.save_game.save()
		var next_scene = Globals.get_scene(level_number + 1)
		Globals.change_level(next_scene)
	else:
		Globals.set_new_score(Globals.score)
		Globals.change_scene("res://scenes/GameOver.tscn")

func start_movement():
	pause_movement = false

func get_success_text() -> String:
	return "Level defeated. Congratulations! \n Next level coming up..."
	
func get_level_name() -> String:
	return "Level %s" % level_number

func get_tutorial_text() -> String:
	return ""

func is_campaign_level() -> bool:
	return true
