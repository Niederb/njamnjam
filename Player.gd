extends Node2D

var direction = Vector2()
var move = true
var length = Globals.START_LENGTH
var dead = false
var new_bodypart_position = Vector2()

func _ready():
	var position_offset = 0
	for _i in range(length):
		var body_part = load("res://scenes/BodyPart.tscn").instance()
		position_offset += Globals.CELL_SIZE
		body_part.global_position.y -= position_offset
		$Body.add_child(body_part)

func run_combo(start_index, combo_size):
	for _i in range(start_index, start_index+combo_size):
		var body_part = $Body.get_child(start_index)
		body_part.die()
		$Body.remove_child(body_part)
	get_tree().call_group("Gamestate", "trigger_combo", combo_size)
	
func check_combo():
	var in_a_row = 0
	var old_color_index = -1
	var start_index = 0
	var index = 0
	for body_part in $Body.get_children():
		var new_color_index = body_part.get_color_index()
		#var goodies = get_adjacent_goodies
		if old_color_index != new_color_index:
			if in_a_row >= Globals.MIN_COMBO_SIZE:
				run_combo(start_index, in_a_row)
			in_a_row = 1
			old_color_index = new_color_index
			start_index = index
		else:
			in_a_row += 1
		index += 1

func move_body():
	var start_position = $Head.global_position
	var collision = $Head.move_and_collide(Globals.CELL_SIZE * direction)
	if collision:
		return true
	for body_part in $Body.get_children():
		var temp_position = body_part.global_position
		body_part.global_position = start_position
		start_position = temp_position
	new_bodypart_position = start_position
	return false

func _physics_process(_delta):
	if move and !dead and direction.length() > 0:
		var dead = move_body()
		if dead:
			return
		move = false
		check_combo()

func _input(_delta):
	if Input.is_action_just_pressed("left"):
		direction = Vector2(-1, 0)
	elif Input.is_action_just_pressed("right"):
		direction = Vector2(1, 0)
	elif Input.is_action_just_pressed("down"):
		direction = Vector2(0, 1)
	elif Input.is_action_just_pressed("up"):
		direction = Vector2(0, -1)

func _on_Timer_timeout():
	move = true

func increase_length(color_index):
	length += 1
	var body_part = load("res://scenes/BodyPart.tscn").instance()
	body_part.modulate_color(color_index)
	$Body.add_child(body_part)
	body_part.global_position = new_bodypart_position
