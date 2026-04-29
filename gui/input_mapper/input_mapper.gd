extends PanelContainer
class_name InputMapper

@export var gui: GUI
@onready var selection_container: SelectionContainer = $MarginContainer/SelectionContainer

func _on_close_button_pressed() -> void:
	hide()
	gui.settings.show()
	gui.settings.selection_container.get_buttons()[0].grab_focus()