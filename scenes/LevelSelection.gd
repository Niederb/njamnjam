extends Control

func _ready():
	var level = Globals.save_game.get_reached_level()
	init_levels(level)

func init_levels(max_level: int) -> void:
	for i in range(1, max_level+1):
		var b = Button.new()
		b.text = "Level %s" % i
		b.connect("pressed", self, "level_button_clicked", [ i ])
		$CenterContainer/VBoxContainer/Levels.add_child(b)

func level_button_clicked(level_number):
	var scene = Globals.get_scene(level_number)
	Globals.change_level(scene)

func _on_Button_pressed():
	Globals.change_scene("res://scenes/MainMenu.tscn")
