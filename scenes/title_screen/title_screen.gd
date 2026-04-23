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
	version_label.text = "v" + ProjectSettings.get_setting("application/config/version")