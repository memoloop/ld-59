extends Node
# Autoload

signal paused(value: bool)

enum State { PLAY, PAUSE, GAME_OVER }
var state: State = State.PLAY

func _init():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _ready() -> void:
	var save_data = SaveManager.get_save_data()

	if not save_data or save_data.is_empty() or save_data.keys() != SaveManager.TEMPLATE.keys():
		SaveManager.create_save()
		save_data = SaveManager.get_save_data()
	
	SaveManager.setup_input()
	AudioServer.set_bus_volume_linear(0, save_data["volume"])
	if save_data["fullscreen"]:
		Utils.toggle_fullscreen()

func _unhandled_input(event):
	match state:

		State.PLAY:
			if get_tree().current_scene is Level and event.is_action_pressed("pause"):
				get_tree().paused = true
				paused.emit(true)
				state = State.PAUSE

		State.PAUSE:
			if get_tree().current_scene is Node2D and event.is_action_pressed("pause"):
				get_tree().paused = false
				paused.emit(false)
				state = State.PLAY

		State.GAME_OVER:
			if OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios"):
				if event is InputEventScreenTouch:
					get_tree().paused = false
					state = State.PLAY
					get_tree().reload_current_scene()
			else:
				if event.is_action_pressed("jump"):
					get_tree().paused = false
					state = State.PLAY
					get_tree().reload_current_scene()
	
	if event.is_action_pressed("fullscreen") and not event.is_echo():
		Utils.toggle_fullscreen()

	# Simulate the custom action with the godot ui action
	if event.is_action_pressed("move_down"):
		Utils.simulate_input_pressed("ui_down")
	elif event.is_action_pressed("move_up"):
		Utils.simulate_input_pressed("ui_up")

func _notification(what):
	if state != State.PLAY: return

	match what:
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			get_tree().paused = true
		NOTIFICATION_APPLICATION_FOCUS_IN:
			get_tree().paused = false
