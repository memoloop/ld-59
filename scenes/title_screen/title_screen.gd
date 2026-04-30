extends Control

@onready var press_E_label: Label = $PressELabel
@onready var move_A_D_label: Label = $MoveADLabel
@onready var version_label: Label = $VersionLabel

func _unhandled_input(event):
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		move_A_D_label.hide()
		press_E_label.show()

func _on_lever_activate_changed(_value: bool):
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _ready():
	version_label.text = "v" + Utils.get_version()

	var save_data = SaveManager.get_save_data()
	if not save_data or save_data.is_empty():
		SaveManager.create_save()
	
	SaveManager.setup_input()

	var input_data = SaveManager.get_save_data()["input"]
	move_A_D_label.text = "Press {0} - {1} to move".format([input_data["move_left"], input_data["move_right"]])
	press_E_label.text = "Press {0} on the lever to start".format([input_data["interact"]])