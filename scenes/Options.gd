extends GridContainer

func _ready():
	update_GUI()
	
func update_GUI() -> void:
	$NumberColors.text = str(Globals.level_config.n_colors)
	$NumberGoodies.text = str(Globals.level_config.n_goodies)
	$MinimalComboSize.text = str(Globals.level_config.min_combo_size)
	$MovementSpeed.text = str(Globals.level_config.movement_speed)

func apply() -> void:
	var new_n_colors = convert_to_int($NumberColors.text, Globals.level_config.n_colors)
	Globals.level_config.n_colors = min(Globals.colors.size(), max(1, new_n_colors))
		
	var new_n_goodies = convert_to_int($NumberGoodies.text, Globals.level_config.n_goodies)
	Globals.level_config.n_goodies = max(1, new_n_goodies)
	
	var new_min_combo_size = convert_to_int($MinimalComboSize.text, Globals.level_config.min_combo_size)
	Globals.level_config.min_combo_size = max(2, new_min_combo_size)
	
	var new_movement_speed = convert_to_int($MovementSpeed.text, Globals.level_config.movement_speed)
	Globals.level_config.movement_speed = max(1, new_movement_speed)

func convert_to_int(text, default) -> int:
	if text.is_valid_integer():
		return int(text)
	else:
		return default
