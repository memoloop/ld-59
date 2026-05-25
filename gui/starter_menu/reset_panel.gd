extends PanelContainer
class_name ResetPanel

@export var starter_menu: StarterMenu
@onready var hbox_selection: HBoxSelection = $MarginContainer/VBoxContainer/HBoxSelection

func _on_yes_button_pressed() -> void:
	SaveManager.create_save()
	StateMachine.state = StateMachine.State.PLAY
	get_tree().change_scene_to_file(SaveManager.get_save_data()["level"])

func _on_no_button_pressed() -> void:
	hide()
	starter_menu.show()
	starter_menu.vbox_selection.get_buttons()[0].grab_focus()
