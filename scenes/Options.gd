extends GridContainer

func _ready():
	update_GUI()
	
func update_GUI():
	$MinimalComboSize.text = str(Globals.MIN_COMBO_SIZE)
	$NumberColors.text = str(Globals.N_COLORS)
	$NumberGoodies.text = str(Globals.N_GOODIES)
	$MovementSpeed.text = str(Globals.MOVEMENT_SPEED)

func apply():
	Globals.MIN_COMBO_SIZE = convert_to_int($MinimalComboSize.text, Globals.MIN_COMBO_SIZE)
	Globals.N_COLORS = convert_to_int($NumberColors.text, Globals.N_COLORS)
	Globals.N_GOODIES = convert_to_int($NumberGoodies.text, Globals.N_GOODIES)
	Globals.MOVEMENT_SPEED = convert_to_int($MovementSpeed.text, Globals.MOVEMENT_SPEED)

func convert_to_int(text, default):
	if text.is_valid_integer():
		return int(text)
	else:
		return default
