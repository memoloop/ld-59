extends Node
class_name SaveManager

const SAVE_PATH: String = "user://save.json"

# This must be a constant, but in constant it isn't use fuction like "Utils.get_version"
# So DON'T MODIFY IN CODE
# Use it like a const
# Also TEMPLATE keys must be in alphabetical order to save data
static var TEMPLATE := {
	"fullscreen": false,
	"input": {
		"move_up": "W",
		"move_down": "S",
		"move_left": "A",
		"move_right": "D",
		"jump": "Space",
		"interact": "E",
		"emit_signal": "Q"
	},
	"level": "res://scenes/levels/level_1.tscn",
	"version": Utils.get_version(),
	"volume": 0.5,
}

static func create_save():
	# Create a new save file
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(TEMPLATE))
		file.close()

static func get_save_data() -> Variant:
	var data := FileAccess.get_file_as_string(SAVE_PATH)
	if data.is_empty(): 
		return null
	return JSON.parse_string(data)

static func setup_input():
	var data = get_save_data()
	if data is Dictionary:
		for action in data["input"]:
			clean_action(action)

			var event := InputEventKey.new()
			event.keycode = OS.find_keycode_from_string(data["input"][action])
			event.pressed = true
			InputMap.action_add_event(action, event)
		
static func clean_action(action: StringName):
	InputMap.erase_action(action)
	InputMap.add_action(action)

static func set_input(action: StringName, event_label: String):
	var data = get_save_data()
	
	if not (data is Dictionary):
		data = TEMPLATE.duplicate(true)

	if not data.has("input"):
		data["input"] = {}

	data["input"][action] = event_label

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

static func set_data(key: String, value: Variant):
	var data = get_save_data()

	if not data is Dictionary:
		data = TEMPLATE.duplicate(true)

	data[key] = value

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
