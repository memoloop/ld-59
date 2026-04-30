extends VBoxContainer
class_name SelectionContainer

func get_buttons() -> Array:
	Utils.temp_out = []
	return Utils.get_children_from_type(self, Button)
