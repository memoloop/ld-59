extends CanvasLayer
class_name MobileLayer

func _on_up_button_pressed() -> void:
	Utils.simulate_input_pressed("jump")

func _on_up_button_released() -> void:
	Utils.simulate_input_pressed("jump", false)
