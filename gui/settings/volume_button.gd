extends Button

var increase: bool = false
var decrease: bool = false

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		increase = false
		decrease = true
	elif event.is_action_pressed("ui_right"):
		increase = true
		decrease = false
	else:
		increase = false
		decrease = false

func _process(_delta: float) -> void:
	if increase:
		AudioServer.set_bus_volume_linear(0, AudioServer.get_bus_volume_linear(0) + 0.1)
	if decrease:
		AudioServer.set_bus_volume_linear(0, AudioServer.get_bus_volume_linear(0) - 0.1)