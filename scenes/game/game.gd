extends Node2D
class_name Game

@export var gui: GUI
@export var player: Player

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	player.stamina = Player.SIGNAL_MAX_PROPAGATION

	for death_zone in Utils.get_children_from_type(self, DeathZone):
		if death_zone and death_zone is DeathZone:
			death_zone.game_over.connect(_on_death_zone_game_over)

	StateMachine.paused.connect(_on_state_machine_paused)

func _on_player_stamina_changed(value: float, max_value: float):
	gui.stamina_bar.value = value
	gui.stamina_bar.max_value = max_value

func _on_death_zone_game_over():
	gui.game_over_label.show()
	gui.resume_label.show()
	StateMachine.state = StateMachine.State.GAME_OVER
	get_tree().paused = true

func _on_state_machine_paused(value: bool):
	gui.pause_label.visible = value
	gui.menu.visible = value
	if value: 
		gui.menu.selection_container.get_buttons()[0].grab_focus()

# ---------------------------
# This is for the web build
# ---------------------------
func _on_audio_stream_player_finished():
	audio.play()
