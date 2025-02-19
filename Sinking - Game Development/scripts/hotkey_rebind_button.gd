#class_name HotkeyRebindButton

extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button
@export var action_name : String = "forward"

var button_setting_text = "Press any key..."
var hotkey_node =  "hotkey_button"

# Displaying Processes
func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()


# Setting the display names
func set_action_name() -> void:
	label.text = "Unassigned"
	
	match action_name:
		"forward":
			label.text = "Move Forward"
		"left":
			label.text = "Move Left"
		"backward":
			label.text = "Move Backward"
		"right":
			label.text = "Move Right"
		"crounch":
			label.text = "Crouch"
		"ability":
			label.text = "Use Ability"
		"switch":
			label.text = "Switch Ability"
		"jump":
			label.text = "Jump"
		"reload":
			label.text = "Restart Level"

# Setting name for rebinded keys
func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	button.text = "%s" % action_keycode


# Button Pressed
func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = button_setting_text
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group(hotkey_node):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		
		for i in get_tree().get_nodes_in_group(hotkey_node):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
				
		set_text_for_key()


# Capture the key input when the button is pressed and awaiting a key
func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false


# Function to rebind the action to the new key
func rebind_action_key(event) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
