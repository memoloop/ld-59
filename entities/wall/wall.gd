extends StaticBody2D
class_name Wall

@export var signal_propagator: SignalPropagator
@export var height: float = 60.0

var start_position: Vector2
var raised_position: Vector2

func _ready():
	start_position = position
	raised_position = start_position
	raised_position.y -= height

	signal_propagator.activate_changed.connect(_on_level_activate_changed)

func _on_level_activate_changed(active: bool):
	var tween := create_tween()

	if active:
		tween.tween_property(self, "position:y", raised_position.y, 3.0)
