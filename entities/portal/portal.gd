extends Area2D
class_name Portal

@export var activated: bool = true
@export var destination: Portal

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.global_position = destination.global_position
