extends Control
class_name OptionsMenu

@onready var back_to_menu = $"MarginContainer/VBoxContainer/Back to Menu" as Button

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

signal exit_options_menu

func _ready():
	pass
