extends Button

var increase: bool = false
var decrease: bool = false

@onready var volume: float = AudioServer.get_bus_volume_linear(0)

func _ready() -> void:
	text = "Volume < >: " + str(int(volume * 100))

func _on_gui_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_left"):
		increase = false
		decrease = true
	elif Input.is_action_pressed("ui_right"):
		increase = true
		decrease = false
	else:
		increase = false
		decrease = false

func _process(_delta: float) -> void:
	if not increase and not decrease: return

	if increase:
		volume += 0.01
	if decrease:
		volume -= 0.01

	volume = clamp(volume, 0.0, 1.0)
	AudioServer.set_bus_volume_linear(0, volume)
	text = "Volume < >: " + str(int(volume * 100))