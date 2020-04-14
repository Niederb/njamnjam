extends GridContainer

func _ready():
	$MinimalComboSize.text = str(Globals.MIN_COMBO_SIZE)
	$NumberColors.text = str(Globals.N_COLORS)
	$NumberGoodies.text = str(Globals.N_GOODIES)
	$MovementSpeed.text = str(1.0 / Globals.TIME_INTERVAL)
	

func apply():
	Globals.MIN_COMBO_SIZE = get_minimal_combo_size()
	Globals.N_COLORS = get_number_of_colors()
	Globals.N_GOODIES = get_number_of_goodies()
	Globals.TIME_INTERVAL = 1.0 / get_movement_speed()

func get_minimal_combo_size():
	return int($MinimalComboSize.text)

func get_number_of_colors():
	return int($NumberColors.text)

func get_movement_speed():
	return int($MovementSpeed.text)

func get_number_of_goodies():
	return int($NumberGoodies.text)
