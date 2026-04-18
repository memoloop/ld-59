extends SignalPropagator
class_name Lever

@onready var sprite: Sprite2D = $Sprite2D

var can_interact: bool = false

func _input(event):
	if not active and can_interact and event.is_action_pressed("interact"):
		active = true
		sprite.frame = active

func _on_area_entered(area: Area2D):
	var parent := area.get_parent()
	if parent and parent is Player:
		can_interact = true

func _on_area_exited(area: Area2D):
	var parent := area.get_parent()
	if parent and parent is Player:
		can_interact = false
