extends Control
class_name OptionsMenu
#signal exit_options_menu
#@onready var back_to_menu = $"MarginContainer/VBoxContainer/Back to Menu" as Button

# Loads menu scene
func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
