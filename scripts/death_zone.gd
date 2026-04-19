extends Area2D
class_name DeathZone

signal game_over

func _ready():
    body_entered.connect(_on_body_entered)

func _on_body_entered(body):
    if body is Player:
        body.anim_sprite.play("death")
        game_over.emit()