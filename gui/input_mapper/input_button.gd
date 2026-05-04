extends Button
class_name InputButton

@export var action_name: StringName

var listen_new_event: bool = false

func _enter_tree() -> void:
	if is_node_ready():
		label_normal_state()

func _ready() -> void:
	create_label()
	pressed.connect(_on_pressed)

func create_label():
	var label := Label.new()
	label.text = get_event().as_text()
	label.position = Vector2(76, 4)
	label.size = Vector2(50, 16)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	add_child(label)

func get_label() -> Label:
	return Utils.get_children_from_type(self, Label)[0]

func get_event():
	return InputMap.action_get_events(action_name)[0]

func set_event(value: InputEvent):
	InputMap.action_erase_event(action_name, get_event())
	InputMap.action_add_event(action_name, value)

func _unhandled_key_input(event: InputEvent) -> void:
	if not listen_new_event: return

	if event is InputEventKey:
		if not event.keycode == KEY_ENTER and not event.alt_pressed and not event.ctrl_pressed and not event.meta_pressed and not event.shift_pressed and event.pressed:
			set_event(event)
			listen_new_event = false
			label_normal_state()
			get_label().text = get_event().as_text()
			SaveManager.set_input(action_name, get_event().as_text())

func _on_pressed():
	listen_new_event = true
	label_listen_state()

func label_normal_state():
	get_label().add_theme_color_override("font_color", Color.WHITE)

func label_listen_state():
	get_label().add_theme_color_override("font_color", Color.SKY_BLUE)
