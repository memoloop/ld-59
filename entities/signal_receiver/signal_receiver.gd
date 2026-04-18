extends SignalPropagator
class_name SignalReceiver

func _on_area_entered(area: Area2D):
	var parent := area.get_parent()
	if parent and parent is Player:
		active = true