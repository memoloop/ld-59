extends Node
# Autoload

signal paused(value: bool)

enum State { PLAY, PAUSE, GAME_OVER }
var state: State = State.PLAY

func _init():
	process_mode = Node.PROCESS_MODE_ALWAYS

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

			# Simulate the custom action with the godot ui action
			if event.is_action_pressed("move_down"):
				Utils.simulate_input_pressed("ui_down")
			elif event.is_action_pressed("move_up"):
				Utils.simulate_input_pressed("ui_up")

		State.GAME_OVER:
			if event.is_action_pressed("jump"):
				get_tree().paused = false
				state = State.PLAY
				get_tree().reload_current_scene()
	
	if event.is_action_pressed("fullscreen") and not event.is_echo():
		Utils.toggle_fullscreen()

func _notification(what):
	if state != State.PLAY: return

	match what:
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			get_tree().paused = true
		NOTIFICATION_APPLICATION_FOCUS_IN:
			get_tree().paused = false
