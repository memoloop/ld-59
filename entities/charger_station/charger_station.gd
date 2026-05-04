extends Area2D
class_name ChargerStation

var player: Player

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body

func _process(delta: float) -> void:
	if player and Input.is_action_pressed("interact"):
		player.stamina += Player.SIGNAL_SPEED * delta

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null