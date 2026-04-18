extends Node2D
class_name Game

@export var gui: GUI
@export var player: Player

func _ready():
	player.stamina = Player.SIGNAL_MAX_PROPAGATION

func _on_player_stamina_changed(value: float, max_value: float):
	gui.stamina_bar.value = value
	gui.stamina_bar.max_value = max_value

func _notification(what):
	match what:
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			get_tree().paused = true
		NOTIFICATION_APPLICATION_FOCUS_IN:
			get_tree().paused = false