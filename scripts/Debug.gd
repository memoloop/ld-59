extends Node
# Autoload

func _ready() -> void:
    # If the version is in development, mute all audio
    # I like listening music when I code...
    if Utils.get_version().contains("-dev"):
        AudioServer.set_bus_mute(0, true)

func _unhandled_key_input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.pressed:
            if event.keycode == KEY_M:
                AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))