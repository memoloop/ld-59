extends CanvasLayer
class_name GUI

@onready var stamina_bar: ProgressBar = $StaminaBar
@onready var stamina_label: Label = $StaminaLabel

@onready var health_bar: ProgressBar = $HealthBar
@onready var health_label: Label = $HealthLabel

@onready var game_over_label: Label = $GameOverLabel
@onready var resume_label: Label = $ResumeLabel

@onready var pause_label: Label = $PauseLabel
@onready var menu: Menu = $Menu
@onready var settings: Settings = $Settings
@onready var input_mapper: InputMapper = $InputMapper

func _ready() -> void:
	StateMachine.paused.connect(_on_state_machine_paused)

	health_bar.value = Player.HEALTH_MAX
	health_bar.max_value = Player.HEALTH_MAX

	stamina_bar.value = Player.SIGNAL_MAX_USE
	stamina_bar.max_value = Player.SIGNAL_MAX_USE

func _on_state_machine_paused(value: bool):
	if value: # When pause is true
		menu.show()
		
	else: # When pause is false
		menu.hide()
		settings.hide()
		input_mapper.hide()
	