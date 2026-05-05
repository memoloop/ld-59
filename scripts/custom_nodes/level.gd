extends Node
class_name Level

@export var gui: GUI
@export var player: Player

@export var audio_player: AudioStreamPlayer

func _ready():
	for death_zone in Utils.get_children_from_type(self, DeathZone):
		if death_zone and death_zone is DeathZone:
			death_zone.game_over.connect(_on_death_zone_game_over)

	StateMachine.paused.connect(_on_state_machine_paused)

func _on_player_stamina_changed(value: float, max_value: float):
	gui.stamina_bar.value = value
	gui.stamina_bar.max_value = max_value

func _on_player_health_changed(value: float, max_value: float) -> void:
	gui.health_bar.value = value
	gui.health_bar.max_value = max_value
	if value <= 0:
		game_over()

func _on_death_zone_game_over():
	game_over()

func game_over():
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
	audio_player.play()
