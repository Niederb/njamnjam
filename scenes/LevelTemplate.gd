extends Node2D

var level_number: int
var level_defeated: bool = false
var pause_movement: bool = true

onready var player = $Players/Player

func _ready():
	add_to_group("LevelTemplate")

func randomize_blocks() -> void:
	for b in $Blocks.get_children():
		if b.color_index == -1:
			var color_index = Globals.get_random_color_index()
			b.modulate_color(color_index)
		else:
			b.apply_color()

func add_goodies() -> void:
	var child_count = $Goodies.get_child_count()
	for _i in range(child_count, Globals.level_config.n_goodies):
		var position = get_valid_position()
		var color_index = Globals.get_random_color_index()
		$Goodies.create_new_goodie(position, color_index)

func head_distance(point) -> float:
	return player.get_node("Head").position.distance_to(point)
	
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
			return position
	return Vector2()

func find_sub_graph(cell, cells, graph_index, graphs):
	var cell_tile_coordinates = $Map.world_to_map(cell.global_position)
	for current_cell in cells:
		if !current_cell.processed() and current_cell.is_active():
			var current_cell_tile_coordinates = $Map.world_to_map(current_cell.global_position)
			var distance = current_cell_tile_coordinates.distance_squared_to(cell_tile_coordinates)
			if head_distance(current_cell.global_position) > 1 and distance <= 1 and current_cell.get_color_index() == cell.get_color_index():
#				print("match")
#				print(cell_tile_coordinates)
#				print(current_cell_tile_coordinates)
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
		if cell.processed() or !cell.is_active():
			continue
		var graph = []
		sub_graphs.push_back(graph)
		sub_graphs[graph_index].push_back(cell.id)
		cell.sub_graph_id = graph_index
		
		find_sub_graph(cell, cells, graph_index, sub_graphs)
		graph_index += 1
	return sub_graphs

func check_combo():
	var body_parts = player.get_body_parts()
	var all_goodies = $Goodies.get_current_goodies()
	var all_blocks = $Blocks.get_children()
	var cells = body_parts + all_goodies + all_blocks
	var sub_graphs = determine_sub_graphs(cells)
	for graph in sub_graphs:
		var min_size_passed = graph.size() >= Globals.level_config.min_combo_size
		if min_size_passed:
			var elements_verified = true
			for element in graph:
				if !cells[element].verify_combo(graph):
					elements_verified = false
					break
			if !elements_verified:
				continue
			player.remove_body_parts(graph)
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
				else:
					n_blocks += 1
					cell.die()
					
			trigger_combo(n_body_parts, n_goodies)

func eaten_goodie(color):
	player.score += 10
	player.increase_length(color)
	$HUD.update_score(player.score)

func trigger_combo(n_body_parts, n_goodies):
	player.score += 10 * n_body_parts * (n_goodies + 1)
	$HUD.update_score(player.score)
	$ComboSFX.play()
	player.combo_count += 1

func _physics_process(_delta):
	if pause_movement:
		player.direction = Vector2()
	elif player.direction != Vector2():
		$LevelInstructions.fade_out()
		
	if player.move_finished():
		var cell_tile_coordinates = $Map.world_to_map(player.position + player.get_node("Head").position)
		#print(cell_tile_coordinates)
		check_combo()
	player.move()
	$HUD.update_fps()
	add_goodies()
	if $WinCondition.check_win(player) == 1 and !level_defeated:
		player.score = 0
		level_defeated = true
		pause_movement = true
		player.direction = Vector2()
		var text = get_success_text()
		$LevelInstructions.show_text(text)
		$NextLevelTimer.start()
		
func game_over():
	player.dead = true
	$LevelInstructions.show_text("Ooops :-( \n Try again!")
	if $NextLevelTimer.is_stopped():
		$NextLevelTimer.start()

func start_game():
	load_map(Globals.level_config.map_name)
	if Globals.level_config.start_cell.length() > 0:
		player.position = Globals.CELL_SIZE * (Globals.level_config.start_cell)
	player.init()
	randomize_blocks()
	
	var intro_text = $WinCondition.get_introduction_text()
	$LevelInstructions.show_level_start(get_level_name(), intro_text, get_tutorial_text())

func load_map(map_name):
	var new_map = load("res://scenes/Maps/%s.tscn" % map_name)
	var new_instance = new_map.instance()
	new_instance.name = "Map"
	$Map.replace_by(new_instance)

func _on_NextLevelTimer_timeout():
	if level_defeated:
		if is_campaign_level():
			Globals.save_game.set_reached_level(level_number + 1)
		var next_scene = Globals.get_scene(level_number + 1)
		Globals.change_level(next_scene)
	else:
		Globals.save_game.verify_high_score(player.score)
		Globals.change_scene("res://scenes/Menu/GameOver.tscn")

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

func pause():
	get_tree().paused = !get_tree().paused
	$HUD.pause(get_tree().paused)

func _input(_delta):
	if Input.is_action_just_pressed("pause"):
		pause()
