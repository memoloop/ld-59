extends CanvasLayer
class_name GUI

@onready var stamina_bar: ProgressBar = $StaminaBar
@onready var stamina_label: Label = $StaminaLabel

@onready var game_over_label: Label = $GameOverLabel
@onready var resume_label: Label = $ResumeLabel

@onready var pause_label: Label = $PauseLabel
@onready var menu: Menu = $Menu
@onready var settings: Settings = $Settings
