extends Level

@onready var portal_2: Portal = $FourthSection/Portal2
@onready var portal_3: Portal = $FourthSection/Portal3
@onready var portal_4: Portal = $FourthSection/Portal4

func _on_signal_receiver_activate_changed(value: bool) -> void:
	portal_2.activated = value
	portal_3.activated = value

func _on_lever_activate_changed(value: bool) -> void:
	portal_4.activated = value
