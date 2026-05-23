extends PanelContainer
class_name ResetPanel

@export var starter_menu: StarterMenu
@onready var hbox_selection: HBoxContainer = $MarginContainer/VBoxContainer/HBoxSelection

func _on_yes_button_pressed() -> void:
	SaveManager.create_save()
	return_to_starter_menu()

func _on_no_button_pressed() -> void:
	return_to_starter_menu()

func return_to_starter_menu():
	hide()
	starter_menu.show()
	starter_menu.vbox_selection.get_buttons()[0].grab_focus()
