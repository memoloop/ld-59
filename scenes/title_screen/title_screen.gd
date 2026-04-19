extends Control

func _on_lever_activate_changed(_value: bool):
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")