extends Area2D
class_name Portal

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var activated: bool = true:
	set(value):
		activated = value
		if is_node_ready():
			anim_sprite.play("activate" if activated else "deactivate")

@export var destination: Portal

func _ready() -> void:
	anim_sprite.play("activate" if activated else "deactivate")

func _on_body_entered(body: Node2D) -> void:
	if activated and body is Player:
		body.global_position = destination.global_position
