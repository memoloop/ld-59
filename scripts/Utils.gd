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

static func internal_get_children_from_type(parent: Node, type):
	for child in parent.get_children():
		if is_instance_of(child, type):
			temp_out.append(child)

static func get_children_from_type(parent: Node, type) -> Array:
	temp_out.clear()
	for child in parent.get_children():
		if is_instance_of(child, type):
			temp_out.append(child)
		internal_get_children_from_type(child, type)

	return temp_out

static func get_version() -> String:
	return ProjectSettings.get_setting("application/config/version")

static func get_separate_words_string(string: String) -> String:
	var snake_case_string := string.to_snake_case()
	var separate_words_string := snake_case_string.replace("_", " ")

	return separate_words_string

static func simulate_input_pressed(action: StringName, pressed: bool = true):
	var input_event_action := InputEventAction.new()
	input_event_action.action = action
	input_event_action.pressed = pressed
	Input.parse_input_event(input_event_action)

static func toggle_fullscreen():
	var window_mode := DisplayServer.window_get_mode()
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_WINDOWED 
		if window_mode == DisplayServer.WINDOW_MODE_FULLSCREEN 
		else DisplayServer.WINDOW_MODE_FULLSCREEN
	)