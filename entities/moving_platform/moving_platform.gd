extends AnimatableBody2D
class_name MovingPlatform

@export var speed: float = 50.0
@export var distance: float = 50.0

var origin_position: Vector2
@export var direction: Vector2

func _ready():
	origin_position = global_position

func _physics_process(delta):
	if direction.x != 0:
		if global_position.x >= origin_position.x + distance:
			direction.x = -1
		elif global_position.x <= origin_position.x - distance:
			direction.x = 1
	
	if direction.y != 0:
		if global_position.y >= origin_position.y + distance:
			direction.y = -1
		elif global_position.y <= origin_position.y - distance:
			direction.y = 1

	global_position += direction * speed * delta
