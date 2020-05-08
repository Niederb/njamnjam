extends VBoxContainer

onready var number_colors = $GridContainer/NumberColors
onready var number_goodies = $GridContainer/NumberGoodies
onready var minimal_combo_size = $GridContainer/MinimalComboSize
onready var movement_speed = $GridContainer/MovementSpeed

var map_names = ["RectangleMap", "FourPillarsMap", "DiagonalPillarsMap", "FourRoomsMap", "TwoHMap"]

func _ready():
	var index = 0
	for map in map_names:
		var icon = load("res://gfx/Maps/%s.png" % map)
		$Level.add_icon_item(icon)
		$Level.set_item_metadata(index, map)
		index += 1
	update_GUI()
	
func update_GUI() -> void:
	for i in $Level.get_item_count():
		if $Level.get_item_metadata(i) == Globals.level_config.map_name:
			$Level.select(i)
	
	number_colors.text = str(Globals.level_config.n_colors)
	number_goodies.text = str(Globals.level_config.n_goodies)
	minimal_combo_size.text = str(Globals.level_config.min_combo_size)
	movement_speed.text = str(Globals.level_config.movement_speed)

func apply() -> void:
	for i in $Level.get_selected_items():
		Globals.level_config.map_name = $Level.get_item_metadata(i)
		
	var new_n_colors = convert_to_int(number_colors.text, Globals.level_config.n_colors)
	Globals.level_config.n_colors = min(Globals.get_number_gameplay_colors(), max(1, new_n_colors))
		
	var new_n_goodies = convert_to_int(number_goodies.text, Globals.level_config.n_goodies)
	Globals.level_config.n_goodies = max(1, new_n_goodies)
	
	var new_min_combo_size = convert_to_int(minimal_combo_size.text, Globals.level_config.min_combo_size)
	Globals.level_config.min_combo_size = max(2, new_min_combo_size)
	
	var new_movement_speed = convert_to_int(movement_speed.text, Globals.level_config.movement_speed)
	Globals.level_config.movement_speed = max(1, new_movement_speed)

func convert_to_int(text, default) -> int:
	if text.is_valid_integer():
		return int(text)
	else:
		return default
