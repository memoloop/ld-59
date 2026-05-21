extends PanelContainer
class_name Menu

@onready var selection_container: SelectionContainer = $MarginContainer/SelectionContainer
@export var gui: GUI

@onready var settings_button: Button = $MarginContainer/SelectionContainer/SettingsButton

func _ready():
	if OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios"):
		settings_button.hide()

func _on_resume_button_pressed() -> void:
	StateMachine.state = StateMachine.State.PLAY
	get_tree().paused = false
	StateMachine.paused.emit(false)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	hide()
	gui.settings.show()
	
	gui.settings.selection_container.get_buttons()[0].grab_focus()
