extends PanelContainer
class_name Settings

@export var gui: GUI
@onready var selection_container: SelectionContainer = $MarginContainer/SelectionContainer
@onready var volume_button: VolumeButton = $MarginContainer/SelectionContainer/VolumeButton

func _on_close_button_pressed() -> void:
	hide()
	gui.menu.show()
	gui.menu.selection_container.get_buttons()[0].grab_focus()

	# Save the volume settings
	SaveManager.set_volume(volume_button.volume)

func _on_input_button_pressed() -> void:
	hide()
	gui.input_mapper.show()
	gui.input_mapper.selection_container.get_buttons()[0].grab_focus()