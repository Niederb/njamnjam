extends GridContainer

func _ready():
	update_GUI()
	
func update_GUI():
	$NumberColors.text = str(Globals.level_config.n_colors)
	$NumberGoodies.text = str(Globals.level_config.n_goodies)
	$MinimalComboSize.text = str(Globals.level_config.min_combo_size)
	$MovementSpeed.text = str(Globals.level.config.movement_speed)

func get_config():
	Globals.level_config.n_colors = convert_to_int($NumberColors.text, Globals.level_config.n_colors)
	Globals.level_config.n_goodies = convert_to_int($NumberGoodies.text, Globals.level_config.n_goodies)
	Globals.level_config.min_combo_size = convert_to_int($MinimalComboSize.text, Globals.level_config.min_combo_size)
	Globals.level.config.movement_speed = convert_to_int($MovementSpeed.text, Globals.level.config.movement_speed)

func convert_to_int(text, default):
	if text.is_valid_integer():
		return int(text)
	else:
		return default
