extends Area2D
class_name SignalPropagator

signal activate_changed(value: bool)

var active: bool = false:
	set(value):
		active = value
		activate_changed.emit(active)
