extends "res://scenes/LevelTemplate.gd"

func _ready():
	load_map("MarinaMap")
	level_number = 4
	Globals.level_config.n_goodies = 3
	$WinCondition.config.combo_count = 3
	start_game()

func get_success_text():
	return "Campaign finished. \n !!Congratulations!! \n Going back to main menu..."

func get_scene(level_number):
	if level_number == self.level_number + 1:
		return "res://scenes/MainMenu.tscn"
	else:
		return "res://scenes/Levels/Level%s.tscn" % (level_number)
