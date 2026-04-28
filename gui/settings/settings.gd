extends PanelContainer
class_name Settings

@export var gui: GUI
@onready var selection_container: VBoxContainer = $MarginContainer/SelectionContainer

func _on_close_button_pressed() -> void:
	hide()
	gui.menu.show()
	gui.menu.selection_container.get_buttons()[0].grab_focus()