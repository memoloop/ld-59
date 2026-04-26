extends PanelContainer
class_name Menu

@onready var selection_container: SelectionContainer = $MarginContainer/SelectionContainer
@onready var settings: PanelContainer = $Settings

func _on_resume_button_pressed() -> void:
	StateMachine.state = StateMachine.State.PLAY
	get_tree().paused = false
	StateMachine.paused.emit(false)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	settings.show()
	release_focus()
	Utils.temp_out = []
	Utils.get_children_from_type(settings, SelectionContainer)[0].get_buttons()[0].grab_focus()
