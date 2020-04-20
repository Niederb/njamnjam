extends Node2D

var direction := Vector2()
var length: int = 0
var dead: bool = false
var tween_done: bool = true
export var player_id: int = 1

func init(length):
	self.length = length
	var position_offset = 0
	for _i in range(length):
		var body_part = load("res://scenes/BodyPart.tscn").instance()
		position_offset += Globals.CELL_SIZE
		body_part.position.y -= position_offset
		$Body.add_child(body_part)
		
func remove_body_parts(indeces):
	var children = []
	for i in indeces:
		if i < $Body.get_child_count():
			children.push_back($Body.get_child(i))
	for c in children:
		c.die()
		$Body.remove_child(c)
	
func get_body_parts():
	return $Body.get_children()

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
		
func check_collision(position):
	var space_state = get_world_2d().get_direct_space_state()
	#var globalpos = self.global_position
	var intersection = space_state.intersect_point(position)
	if intersection:
		get_tree().call_group("Gamestate", "game_over")
		$DieSFX.play()
		dead = true
		return

func move_body():
	var start_position = $Head.position
	var end_position = $Head.position + Globals.CELL_SIZE * direction
	check_collision(self.global_position + end_position)
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

func increase_length(color_index):
	$GoodieSFX.play()
	length += 1
	var body_part = load("res://scenes/BodyPart.tscn").instance()
	body_part.initialize($Head.position, color_index)
	$Body.add_child(body_part)

func move_finished() -> bool:
	return tween_done

func _on_Tween_tween_all_completed():
#	$Head.global_position = wrap_position($Head.global_position)
#	for body_part in $Body.get_children():
#		body_part.global_position = wrap_position(body_part.global_position)
	tween_done = true
