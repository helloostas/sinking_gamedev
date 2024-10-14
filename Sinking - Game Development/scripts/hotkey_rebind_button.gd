class_name HotkeyRebindButton
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button

@export var action_name : String = "forward"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()

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
		"crouch":
			label.text = "Crouch"
		"ability":
			label.text = "Use Ability"
		"switch":
			label.text = "Switch Ability"
		"ui_accept":
			label.text = "Jump"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	print(action_keycode)
	
