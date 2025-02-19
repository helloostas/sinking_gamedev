extends Control
@onready var option_button = $HBoxContainer/OptionButton as OptionButton

# Resolution options
const RESOLUTION_DICTIONARY : Dictionary = {
	"1920 x 1080" : Vector2i(1920, 1080),
	"2560 x 1440" : Vector2i(2560, 1440),
	"3840 x 2160" : Vector2i(3840, 2160),
}

# Loading resolution options to the button on scene entrance
func _ready():
	add_resolution_items()
	option_button.item_selected.connect(on_resolution_selected)


# Adding resolution options to the button
func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)


# Setting resolution size
func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
