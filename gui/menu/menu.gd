extends PanelContainer
class_name Menu

@onready var vbox_selection: VBoxSelection = $MarginContainer/VBoxSelection
@export var gui: GUI

@onready var settings_button: Button = $MarginContainer/VBoxSelection/SettingsButton

func _ready():
	if OS.has_feature("mobile") or OS.has_feature("web_android") or OS.has_feature("web_ios"):
		settings_button.hide()

func _on_resume_button_pressed() -> void:
	StateMachine.state = StateMachine.State.PLAY
	get_tree().paused = false
	StateMachine.paused.emit(false)

func _on_settings_button_pressed() -> void:
	hide()
	gui.settings.show()
	
	gui.settings.vbox_selection.get_buttons()[0].grab_focus()

func _on_return_to_title_button_pressed() -> void:
	StateMachine.state = StateMachine.State.PLAY
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title_screen/title_screen.tscn")
