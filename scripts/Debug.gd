extends Node
# Autoload

func _ready() -> void:
    # If the version is in development, mute all audio
    # I like listening music when I code...
    if Utils.get_version().contains("-dev"):
        AudioServer.set_bus_mute(0, true)