extends Node
class_name SaveManager

const SAVE_PATH: String = "user://save.json"

const TEMPLATE := {
	"input": {
		"move_up": "W",
		"move_down": "S",
		"move_left": "A",
		"move_right": "D",
		"jump": "Space",
		"interact": "E",
		"emit_signal": "Q"
	},
	"volume": 0.5
}

static func create_save():
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

static func set_volume(volume: float):
	var data = get_save_data()
	
	if not (data is Dictionary):
		data = TEMPLATE.duplicate(true)

	data["volume"] = volume

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()