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
		$Map.add_icon_item(icon)
		$Map.set_item_metadata(index, map)
		index += 1
	update_GUI()
	
func update_GUI() -> void:
	for i in $Map.get_item_count():
		if $Map.get_item_metadata(i) == Globals.level_config.map_name:
			$Map.select(i)
	
	number_colors.value = Globals.level_config.n_colors
	number_goodies.value = Globals.level_config.n_goodies
	minimal_combo_size.value = Globals.level_config.min_combo_size
	movement_speed.value = Globals.level_config.movement_speed

func apply() -> void:
	for i in $Map.get_selected_items():
		Globals.level_config.map_name = $Map.get_item_metadata(i)
		
	Globals.level_config.n_colors = min(Globals.get_number_gameplay_colors(), number_colors.value)
		
	Globals.level_config.n_goodies = number_goodies.value
	Globals.level_config.min_combo_size = minimal_combo_size.value
	Globals.level_config.movement_speed = movement_speed.value
