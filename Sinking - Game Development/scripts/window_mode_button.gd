extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

# Window options
const WINDOW_MODE_ARRAY : Array[String] = [
	"Window Mode",
	"Full-Screen",
	"Borderless Window Mode",
	"Borderless Full-screen",
]

# Loading view options to the button on scene entrance
func _ready():
	add_window_mode_items()
	option_button.item_selected.connect(on_window_mode_selected)


# Adding view options to the window button
func add_window_mode_items() -> void:
	for window_mode in WINDOW_MODE_ARRAY:
		option_button.add_item(window_mode)


# Setting window sizes through matching the array options to their respective window settings
func on_window_mode_selected(index : int) -> void:
	match index:
		0: # Window Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			
		1: # Full Screen 
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			
		2: # Borderless Window Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			
		3: # Borderless Full Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
