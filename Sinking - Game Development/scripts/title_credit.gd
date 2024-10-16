extends Control

@onready var transition = $transition
@onready var color_rect = $transition/ColorRect

var title_credits_2 = preload("res://scenes/title_credits_pt2.tscn")

func _on_transition_animation_finished(anim_name):
	get_tree().change_scene_to_packed(title_credits_2)
