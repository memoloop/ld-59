extends Button
class_name VolumeButton

var increase: bool = false
var decrease: bool = false

@onready var volume: float = 0.5
var step: float = 0.001

func _ready() -> void:
	gui_input.connect(_on_gui_input)

	var data = SaveManager.get_save_data()
	if data is Dictionary:
		volume = data["volume"]
	AudioServer.set_bus_volume_linear(0, volume)
	text = "Volume < >: " + str(int(volume * 100))

func _on_gui_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		increase = false
		decrease = true
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		increase = true
		decrease = false
	else:
		increase = false
		decrease = false

func _process(_delta: float) -> void:
	if not increase and not decrease: return

	if increase:
		volume += step
	if decrease:
		volume -= step

	volume = clamp(volume, 0.0, 1.0)
	AudioServer.set_bus_volume_linear(0, volume)
	text = "Volume < >: " + str(int(volume * 100))
