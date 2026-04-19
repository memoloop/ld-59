extends Node
class_name Utils

static var temp_out = []

static func get_direction_string(direction: Vector2) -> String:
	if direction.x < 0 and direction.y < 0:
		return "up left"
	if direction.x == 0 and direction.y < 0:
		return "up"
	if direction.x > 0 and direction.y < 0:
		return "up right"
	if direction.x < 0 and direction.y == 0:
		return "left"
	if direction.x == 0 and direction.y == 0:
		return "none"
	if direction.x > 0 and direction.y == 0:
		return "right"
	if direction.x < 0 and direction.y > 0:
		return "down left"
	if direction.x == 0 and direction.y > 0:
		return "down"
	if direction.x > 0 and direction.y > 0:
		return "down right"

	return "none"

static func get_children_from_type(parent: Node, type) -> Array:
	for child in parent.get_children():
		if is_instance_of(child, type):
			temp_out.append(child)
		get_children_from_type(child, type)

	return temp_out
