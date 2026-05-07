extends PanelContainer
class_name InputMapper

@export var settings: Settings
@onready var selection_container: SelectionContainer = $MarginContainer/SelectionContainer

func _on_close_button_pressed() -> void:
	hide()
	settings.show()
	settings.selection_container.get_buttons()[0].grab_focus()