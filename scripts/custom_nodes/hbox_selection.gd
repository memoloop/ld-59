extends HBoxContainer
class_name HBoxSelection

func get_buttons() -> Array:	
	return Utils.get_children_from_type(self, Button)