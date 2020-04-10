extends Node2D

var direction = Vector2()
var length = Globals.START_LENGTH
var dead = false
var new_bodypart_position = Vector2()
var tween_done = true

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
	
func get_body_parts():
	return $Body.get_children()

func move_body():
	var start_position = global_position
	#var collision = $Head.move_and_slide(Globals.CELL_SIZE * direction)
	var end_position = global_position + Globals.CELL_SIZE * direction
	$Tween.interpolate_property(self, "global_position",
		start_position, end_position, Globals.TIME_INTERVAL,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween_done = false
	var collision = false
	if collision:
		dead = true
		return true
	for body_part in $Body.get_children():
		start_position = body_part.move_to($Tween, start_position)
	new_bodypart_position = start_position
	$Tween.start()
	return false

func move():
	if tween_done and !dead and direction.length() > 0:
		var dead = move_body()		

func _input(_delta):
	if Input.is_action_just_pressed("left"):
		direction = Vector2(-1, 0)
	elif Input.is_action_just_pressed("right"):
		direction = Vector2(1, 0)
	elif Input.is_action_just_pressed("down"):
		direction = Vector2(0, 1)
	elif Input.is_action_just_pressed("up"):
		direction = Vector2(0, -1)

func increase_length(color_index):
	length += 1
	var body_part = load("res://scenes/BodyPart.tscn").instance()
	body_part.modulate_color(color_index)
	$Body.add_child(body_part)
	#body_part.global_position = new_bodypart_position

func move_finished():
	return tween_done

func _on_Tween_tween_all_completed():
	tween_done = true
