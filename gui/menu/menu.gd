extends PanelContainer
class_name Menu

@onready var selection_container: SelectionContainer = $MarginContainer/SelectionContainer
@export var gui: GUI

func _on_resume_button_pressed() -> void:
	StateMachine.state = StateMachine.State.PLAY
	get_tree().paused = false
	StateMachine.paused.emit(false)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	hide()
	gui.settings.show()
	Utils.temp_out = []
	gui.settings.selection_container.get_buttons()[0].grab_focus()
