extends VBoxContainer
class_name VBoxSelection

func get_buttons() -> Array:	
	return Utils.get_children_from_type(self, Button)