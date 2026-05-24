extends Area2D
class_name Door

@export var next_level: PackedScene

func _on_body_entered(body: Node2D):
	if body is Player:
		get_tree().call_deferred("change_scene_to_packed", next_level)
		if next_level.instantiate() is Level:
			SaveManager.set_data("level", next_level.resource_path)