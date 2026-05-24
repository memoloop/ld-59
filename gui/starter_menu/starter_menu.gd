extends PanelContainer
class_name StarterMenu

@onready var vbox_selection: VBoxSelection = $MarginContainer/VBoxSelection
@export var settings: Settings
@export var reset_panel: ResetPanel
@onready var settings_button: Button = $MarginContainer/VBoxSelection/SettingsButton

func _ready() -> void:
	vbox_selection.get_buttons()[0].grab_focus()
	
	if OS.has_feature("mobile"):
		settings_button.hide()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(SaveManager.get_save_data()["level"])

func _on_settings_button_pressed() -> void:
	hide()
	settings.show()
	settings.vbox_selection.get_buttons()[0].grab_focus()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_new_game_button_pressed() -> void:
	hide()
	reset_panel.show()
	reset_panel.hbox_selection.get_buttons()[0].grab_focus()
