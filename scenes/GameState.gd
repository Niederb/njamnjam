extends Node2D

var score = 0
var move = true
	
func _ready():
	add_to_group("Gamestate")
	for i in range(Globals.N_GOODIES):
		add_goodie()

func add_goodie():
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
			return position
	return Vector2()

func get_sub_graphs(cells, min_size):
	var sub_graphs = []
	for cell in cells.len():
		pass
		#find_neighbor(cell, cells)
	return sub_graphs

func get_adjacent_goodies(position, color_index, goodies):
	var adjacent = []
	for g in goodies:
		var distance = (g.global_position - position).length()
		var head_distance = ($Player/Head.global_position - position).length()
		
		if head_distance > Globals.CELL_SIZE and distance <= Globals.CELL_SIZE and g.get_color_index() == color_index and g.is_active():
			adjacent.push_back(g)
		elif distance < Globals.CELL_SIZE + 10:
			print("Very close: %s" % distance)
	if adjacent.size() > 0:
		print("Found adjacent: %s" % adjacent.size())
	return adjacent
			

func check_combo():
	print("Check combo")
	var combo_size = 0
	var old_color_index = -1
	var start_index = 0
	var index = 0
	var sequential_body_parts = 0
	
	var body_parts = $Player.get_body_parts()
	var all_goodies = $Goodies.get_current_goodies()
	var combo_goodies = []
	var color_indices = []
	
	for body_part in body_parts:
		var position = body_part.global_position
		var new_color_index = body_part.get_color_index()
		color_indices.push_back(new_color_index)
		if old_color_index != new_color_index:
			if combo_size >= Globals.MIN_COMBO_SIZE:
				for g in combo_goodies:
					g.die()
					add_goodie()
				print("Combo: %s/%s" % [combo_size, sequential_body_parts])
				$Player.run_combo(start_index, sequential_body_parts)
			combo_goodies = []
			combo_size = 1
			sequential_body_parts = 1
			old_color_index = new_color_index
			start_index = index
		else:
			combo_size += 1
			sequential_body_parts += 1
		
		var adjacent_goodies = get_adjacent_goodies(position, new_color_index, all_goodies)
		combo_size += adjacent_goodies.size()
		combo_goodies += adjacent_goodies
		
		index += 1
	print("Colors %s" % PoolStringArray(color_indices).join(", "))
	#var cells = body_parts + goodies
	#var sub_graphs = get_sub_graphs(cells, Globals.MIN_COMBO_SIZE)

func eaten_goodie(color):
	print("Eaten goodie")
	score += 10
	$Player.increase_length(color)
	add_goodie()
	$GUI.update_score(score)

func trigger_combo(combo_size):
	score += 10 * combo_size
	$GUI.update_score(score)

func _physics_process(_delta):
	if move:
		$Player.move()
		check_combo()
		move = false

func _on_Timer_timeout():
	move = true
