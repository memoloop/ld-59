extends Node
class_name Utils

static func get_direction_string(direction: Vector2) -> String:
    if direction.x < 0 and direction.y < 0:
        return "up left"
    if direction.x == 0 and direction.y < 0:
        return "up"
    if direction.x > 0 and direction.y < 0:
        return "up right"
    if direction.x < 0 and direction.y == 0:
        return "left"
    if direction.x == 0 and direction.y == 0:
        return "none"
    if direction.x > 0 and direction.y == 0:
        return "right"
    if direction.x < 0 and direction.y > 0:
        return "down left"
    if direction.x == 0 and direction.y > 0:
        return "down"
    if direction.x > 0 and direction.y > 0:
        return "down right"

    return "none"