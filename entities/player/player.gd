extends CharacterBody2D
class_name Player

signal stamina_changed(value: float, max_value: float)
signal health_changed(value: float, max_value: float)

const SPEED: float = 120.0
const JUMP_VELOCITY: float = -350.0

const SIGNAL_SPEED: float = 75.0
const SIGNAL_MIN_PROPAGATION: float = 10.0
const SIGNAL_MAX_PROPAGATION: float = 150.0
const SIGNAL_MAX_USE: float = 250.0

const HEALTH_MAX: float = 100.0
const HEALTH_DAMAGE_SPEED: float = 15.0

var anim_propagation: StringName = "stamina"

var stamina: float = SIGNAL_MAX_USE:
	set(value):
		stamina = clamp(value, 0, SIGNAL_MAX_USE)
		anim_propagation = "emit_signal"
		stamina_changed.emit(stamina, SIGNAL_MAX_USE)

var health: float = HEALTH_MAX:
	set(value):
		health = clamp(value, 0, HEALTH_MAX)
		anim_propagation = "no_signal"
		health_changed.emit(health, HEALTH_MAX)

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $SignalArea/CollisionShape2D
@onready var interact_area: Area2D = $InteractArea
@onready var signal_area: Area2D = $SignalArea

@export var infinite_stamina: bool = false

var direction: Vector2

var can_interact: bool = false

var previous_vel: Vector2

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

	# Propagate the signal
	if is_on_floor() and direction.x == 0 and Input.is_action_pressed("emit_signal"):
		can_interact = true
		var shape := get_shape()
		if stamina > 0:
			stamina -= SIGNAL_SPEED * delta # Stamina decreases
		else:
			health -= HEALTH_DAMAGE_SPEED * delta # Health decreases if the stamina is finished
		if stamina >= SIGNAL_MIN_PROPAGATION or health > 0:
			shape.radius += SIGNAL_SPEED * delta # The shape radius increase by SIGNAL_SPEED * delta
			shape.radius = clamp(shape.radius, SIGNAL_MIN_PROPAGATION, SIGNAL_MAX_PROPAGATION) # Max and min radius size
		else:
			can_interact = false
	else:
		get_shape().radius = SIGNAL_MIN_PROPAGATION

	handle_animation()

	move_and_slide() # Update the position of the player modifying the velocity property

func _process(_delta):
	queue_redraw() # Call the _draw() method every frame.

func _draw():
	var color1: Color
	var color2: Color
	if anim_propagation == "emit_signal":
		color1 = Color.LIGHT_BLUE
		color2 = Color.DARK_BLUE
	elif anim_propagation == "no_signal":
		color1 = Color.INDIAN_RED
		color2 = Color.DARK_RED
	
	if get_shape().radius > SIGNAL_MIN_PROPAGATION:
		# Draw concentric circles that represents the propagation waves of the signal.
		draw_circle(signal_area.position, get_shape().radius / 4, color1, false) # Smallest and innermost
		draw_circle(signal_area.position, get_shape().radius / 2, color2, false) # Middle wave
		draw_circle(signal_area.position, get_shape().radius, color1, false) # Bigger and outermost

func get_shape() -> CircleShape2D:
	# Return the shape member of collision_shape
	var shape := collision_shape.shape
	if shape is CircleShape2D:
		return shape
	
	return null # You must add a CircleShape2d node or set collision.shape as CircleShape2D

func handle_animation():
	if not infinite_stamina and health <= 0:
		anim_sprite.play("death")
	elif get_shape().radius > SIGNAL_MIN_PROPAGATION:
		anim_sprite.play(anim_propagation)
	elif velocity.y < 0:
		anim_sprite.play("jump")
	elif velocity.y > 0:
		anim_sprite.play("fall")
	elif previous_vel.y != velocity.y:
		anim_sprite.play("bounch")
	elif anim_sprite.animation == "bounch":
		await anim_sprite.animation_finished
		anim_sprite.play("idle")
	else:
		anim_sprite.play("idle")

	# Flip
	if velocity.x > 0:
		anim_sprite.flip_h = false
	elif velocity.x < 0:
		anim_sprite.flip_h = true

	previous_vel = velocity