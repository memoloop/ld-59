extends PanelContainer
class_name StarterMenu

@onready var selection_container: SelectionContainer = $MarginContainer/SelectionContainer
@export var settings: Settings

func _ready() -> void:
	selection_container.get_buttons()[0].grab_focus()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_settings_button_pressed() -> void:
	hide()
	settings.show()
	settings.selection_container.get_buttons()[0].grab_focus()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
