extends CharacterBody2D
class_name Player

signal stamina_changed(value: float)

const SPEED: float = 120.0
const JUMP_VELOCITY: float = -350.0
const SIGNAL_SPEED: float = 100.0
const SIGNAL_MIN_PROPAGATION: float = 10.0
const SIGNAL_MAX_PROPAGATION: float = 150.0

var stamina: float:
	set(value):
		stamina = clamp(value, 0, SIGNAL_MAX_PROPAGATION)
		stamina_changed.emit(stamina, SIGNAL_MAX_PROPAGATION)

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $SignalArea/CollisionShape2D
@onready var interact_area: Area2D = $InteractArea

var direction: Vector2

var can_interact: bool = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		direction.y = 1
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		direction.y = -1
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	direction.x = Input.get_axis("move_left", "move_right")
	velocity.x = direction.x * SPEED

	# Handle the animation
	var dir_string := Utils.get_direction_string(direction)
	if "right" in dir_string:
		anim_sprite.flip_h = false
	elif "left" in dir_string:
		anim_sprite.flip_h = true

	if is_on_floor() and Input.is_action_pressed("emit_signal"):
		var shape := get_shape()
		stamina -= SIGNAL_SPEED * delta
		if stamina >= SIGNAL_MIN_PROPAGATION:
			anim_sprite.play("emit_signal")
			shape.radius += SIGNAL_SPEED * delta
			shape.radius = clamp(shape.radius, SIGNAL_MIN_PROPAGATION, SIGNAL_MAX_PROPAGATION)
		else:
			anim_sprite.play("no_signal")
	else:
		anim_sprite.play("idle")
		get_shape().radius = SIGNAL_MIN_PROPAGATION
		stamina += SIGNAL_SPEED * delta

	move_and_slide()

func get_shape() -> CircleShape2D:
	var shape := collision_shape.shape
	if shape is CircleShape2D:
		return shape
	
	return null
