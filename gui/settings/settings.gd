extends PanelContainer
class_name Settings

@export var previous_menu: Control
@export var input_mapper: InputMapper

@onready var vbox_selection: VBoxSelection = $MarginContainer/VBoxSelection
@onready var volume_button: VolumeButton = $MarginContainer/VBoxSelection/VolumeButton
@onready var fullscreen_button: Button = $MarginContainer/VBoxSelection/FullscreenButton

func _ready() -> void:
	fullscreen_button.text = "Fullscreen: " + ("on" if DisplayServer.window_get_mode() == Window.MODE_FULLSCREEN else "off")

func _on_close_button_pressed() -> void:
	hide()
	previous_menu.show()
	previous_menu.vbox_selection.get_buttons()[0].grab_focus()

func _on_input_button_pressed() -> void:
	hide()
	input_mapper.show()
	input_mapper.vbox_selection.get_buttons()[0].grab_focus()

func _on_fullscreen_button_pressed() -> void:
	Utils.toggle_fullscreen()
	fullscreen_button.text = "Fullscreen: " + ("on" if DisplayServer.window_get_mode() == Window.MODE_FULLSCREEN else "off")
	SaveManager.set_data("fullscreen", DisplayServer.window_get_mode() == Window.MODE_FULLSCREEN)
