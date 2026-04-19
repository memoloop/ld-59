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
			if get_tree().current_scene is Node2D and event.is_action_pressed("pause"):
				get_tree().paused = true
				paused.emit(true)
				state = State.PAUSE

		State.PAUSE:
			if get_tree().current_scene is Node2D and event.is_action_pressed("pause"):
				get_tree().paused = false
				paused.emit(false)
				state = State.PLAY

		State.GAME_OVER:
			if event.is_action_pressed("jump"):
				get_tree().paused = false
				state = State.PLAY
				get_tree().reload_current_scene()
	
	if event.is_action_pressed("fullscreen") and not event.is_echo():
		var window_mode := DisplayServer.window_get_mode()
		DisplayServer.window_set_mode(
			DisplayServer.WINDOW_MODE_WINDOWED 
			if window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN 
			else DisplayServer.WINDOW_MODE_FULLSCREEN
		)