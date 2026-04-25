extends Area2D
class_name DeathZone

signal game_over

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is Player:
		body.anim_sprite.play("death")
		game_over.emit()

func get_collision_shape() -> CollisionShape2D:
	Utils.temp_out = []
	var collision_shapes := Utils.get_children_from_type(self, CollisionShape2D)
	if not collision_shapes.is_empty():
		return collision_shapes[0]

	return null
