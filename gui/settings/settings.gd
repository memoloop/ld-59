extends PanelContainer
class_name Settings

@export var gui: GUI
@onready var selection_container: SelectionContainer = $MarginContainer/SelectionContainer
@onready var volume_button: VolumeButton = $MarginContainer/SelectionContainer/VolumeButton
@onready var fullscreen_button: Button = $MarginContainer/SelectionContainer/FullscreenButton

func _ready() -> void:
	fullscreen_button.text = "Fullscreen: " + ("on" if DisplayServer.window_get_mode() == Window.MODE_FULLSCREEN else "off")

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

func _on_fullscreen_button_pressed() -> void:
	Utils.toggle_fullscreen()
	fullscreen_button.text = "Fullscreen: " + ("on" if DisplayServer.window_get_mode() == Window.MODE_FULLSCREEN else "off")
