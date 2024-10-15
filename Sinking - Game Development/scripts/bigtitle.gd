extends Control
@onready var timer = $MarginContainer/Timer

func _ready():
	timer.start()
	pass


func _process(delta):
	pass


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	pass # Replace with function body.
