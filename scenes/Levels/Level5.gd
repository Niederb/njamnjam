extends "res://scenes/LevelTemplate.gd"

func _ready():
	load_map("RoomMap")
	level_number = 5
	Globals.level_config.n_goodies = 0
	$WinCondition.config.combo_count = 2
	start_game()

func get_success_text():
	return "Campaign finished. \n !!Congratulations!! \n Going back to main menu..."

func get_scene(level_number):
	if level_number == self.level_number + 1:
		return "res://scenes/MainMenu.tscn"
	else:
		return "res://scenes/Levels/Level%s.tscn" % (level_number)
