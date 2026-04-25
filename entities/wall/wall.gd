extends StaticBody2D
class_name Wall

enum Movement { HORIZONTAL, VERTICAL }

@export var signal_propagator: SignalPropagator
@export var distance: float = 60.0

var start_position_coord: float
var raised_position_coord: float
@export var movement: Movement = Movement.VERTICAL

@onready var death_zone: DeathZone = $DeathZone

var property_to_change: NodePath

var tween: Tween

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
	if tween:
		tween.kill()
	tween = create_tween()

	if active: # Open the wall
		death_zone.get_collision_shape().set_deferred("disabled", true)
		tween.tween_property(self, property_to_change, raised_position_coord, 3.0)
	else: # Close the wall
		tween.tween_property(self, property_to_change, start_position_coord, 3.0)
		await tween.finished
		death_zone.get_collision_shape().set_deferred("disabled", false)

