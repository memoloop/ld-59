extends PanelContainer
class_name InputMapper

@export var settings: Settings
@onready var vbox_selection: VBoxContainer = $MarginContainer/VBoxSelection

func _on_close_button_pressed() -> void:
	hide()
	settings.show()
	settings.vbox_selection.get_buttons()[0].grab_focus()