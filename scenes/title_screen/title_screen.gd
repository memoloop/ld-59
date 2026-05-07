extends Control

@onready var version_label: Label = $VersionLabel
@onready var title_label: Label = $TitleLabel
@onready var dev_label: Label = $DevLabel

@onready var input_mapper: InputMapper = $InputMapper

func _ready():
	version_label.text = "v" + Utils.get_version()

func _on_input_mapper_visibility_changed() -> void:
	version_label.visible = not input_mapper.visible
	title_label.visible = not input_mapper.visible
	dev_label.visible = not input_mapper.visible