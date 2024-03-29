extends Node2D

var direction := Vector2()
var dead: bool = false
var tween_done: bool = true
export var player_id: int = 1

var steps: int = 0
var score: int = 0
var combo_count: int = 0
var multi_combo_count: int = 0
var level_instance: String
var block_actions: int = 0

func init(level_instance, initial_body_parts):
	var next_position = $Head.position
	for color_index in initial_body_parts:
		next_position -= Vector2(Globals.CELL_SIZE, 0.0)
		add_body_part(next_position, color_index)

	self.level_instance = level_instance
		
func remove_body_parts(sub_graphs):
	var children = []
	for graph in sub_graphs:
		for i in graph:
			if i < $Body.get_child_count():
				children.push_back($Body.get_child(i))
	for c in children:
		c.die()
		$Body.remove_child(c)

func get_cells():
	return get_body_parts()

func get_body_parts():
	return $Body.get_children()

func get_length():
	return $Body.get_child_count()

func wrap_position(position):
	var ZERO = Vector2()
	var MAX = Globals.LEVEL_SIZE * Globals.CELL_SIZE
	if position.x < ZERO.x:
		position.x = MAX.x + position.x
	if position.y < ZERO.y:
		position.y = MAX.y + position.y
	if position.x > MAX.x:
		position.x = ZERO.x - position.x
	if position.y > MAX.y:
		position.y = ZERO.y - position.y
	return position

func move_body():
	var start_position = $Head.position
	var end_position = $Head.position + Globals.CELL_SIZE * direction

	if dead:
		return
	$Tween.interpolate_property($Head, "position",
		start_position, end_position, Globals.level_config.get_time_interval(),
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)	
	tween_done = false

	for body_part in $Body.get_children():
		start_position = body_part.move_to($Tween, start_position)
	$Tween.start()

func move():
	if tween_done and !dead and direction.length() > 0:
		steps += 1
		move_body()		

func _input(_delta):
	if Input.is_action_just_pressed("left_%s"%player_id):
		direction = Vector2(-1, 0)
	elif Input.is_action_just_pressed("right_%s"%player_id):
		direction = Vector2(1, 0)
	elif Input.is_action_just_pressed("down_%s"%player_id):
		direction = Vector2(0, 1)
	elif Input.is_action_just_pressed("up_%s"%player_id):
		direction = Vector2(0, -1)
	elif Input.is_action_just_pressed("add_block"):
		if block_actions > 0:
			block_actions -= 1
			increase_length(0)
			get_tree().call_group(level_instance, "update_separator_action")

func add_body_part(position: Vector2, color_index: int):
	var body_part = load("res://scenes/BodyPart.tscn").instance()
	body_part.initialize(position, color_index)
	body_part.connect("area_entered", self, "_on_Head_area_entered")
	$Body.add_child(body_part)

func increase_length(color_index):
	$GoodieSFX.play()
	add_body_part($Head.position, color_index)

func move_finished() -> bool:
	return tween_done

func die():
	if !dead:
		$DieSFX.play()
		dead = true
		get_tree().call_group(level_instance, "game_over")

func _on_Tween_tween_all_completed():
#	$Head.global_position = wrap_position($Head.global_position)
#	for body_part in $Body.get_children():
#		body_part.global_position = wrap_position(body_part.global_position)
	tween_done = true

# Wall collision
func _on_Head_body_entered(body):
	if body.collision_layer == 8:
		die()

func _on_Head_area_entered(area):
	if area.collision_layer == 1:
		die()	
	elif area.collision_layer == 4:
		die()
