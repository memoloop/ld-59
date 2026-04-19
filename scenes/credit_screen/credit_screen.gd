extends Control

func _on_signal_receiver_activate_changed(_value: bool):
	get_tree().call_deferred("change_scene_to_file", "res://scenes/title_screen/title_screen.tscn")