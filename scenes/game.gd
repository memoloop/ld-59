extends Node2D
class_name Game

@export var gui: GUI
@export var player: Player

func _ready():
	player.stamina = Player.SIGNAL_MAX_PROPAGATION

func _on_player_stamina_changed(value: float, max_value: float):
	gui.stamina_bar.value = value
	gui.stamina_bar.max_value = max_value
