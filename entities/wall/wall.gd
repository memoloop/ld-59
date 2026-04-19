extends StaticBody2D
class_name Wall

enum Movement { HORIZONTAL, VERTICAL }

@export var signal_propagator: SignalPropagator
@export var distance: float = 60.0

var start_position_coord: float
var raised_position_coord: float
@export var movement: Movement = Movement.VERTICAL

var property_to_change: NodePath 

func _ready():
	match movement:
		Movement.HORIZONTAL:
			start_position_coord = global_position.x
			property_to_change = "position:x"
		Movement.VERTICAL:
			start_position_coord = global_position.y
			property_to_change = "position:y"

	raised_position_coord = start_position_coord
	raised_position_coord -= distance

	signal_propagator.activate_changed.connect(_on_level_activate_changed)

func _on_level_activate_changed(active: bool):
	var tween := create_tween()

	if active:
		tween.tween_property(self, property_to_change, raised_position_coord, 3.0)
	else:
		tween.tween_property(self, property_to_change, start_position_coord, 3.0)
