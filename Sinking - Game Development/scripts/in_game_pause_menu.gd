extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var animation_player = $AnimationPlayer # this may not be necessary

@onready var resume_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeButton
@onready var settings_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/SettingsButton
@onready var quit_button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/QuitButton

func _ready() -> void:
	resume_button.pressed.connect(unpause)
	#quit_button.pressed.connect(get_tree().quit)

func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	animator.play("Pause")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_settings_button_pressed():
	if get_tree().paused:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://scenes/settings.tscn")

func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
