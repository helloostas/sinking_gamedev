extends Node3D

@onready var player = $player
@onready var transition = $transition
@onready var text_one = $text_one
@onready var text_two = $text_two
@onready var sinking_animation = $sinking_animation

var player_meta = "player"

func _ready():
	start_function()

# Loads scene animations
func start_function():
	#print("The scene has loaded, and this function is now running!")
	transition.play("fade_in")
	text_one.play("text1 disappear")
	text_two.play("text two start")
	sinking_animation.play("sinking_start")


# All checks for collision with Area3D node and plays animation if colliding
func _on_intro_words_1_body_entered(body):
	if body.has_meta(player_meta):
		#print("check_1")
		text_one.play("text1 disappear")


func _on_intro_words_2_body_entered(body):
	if body.has_meta(player_meta):
		#print("check_2")
		text_two.play("text two start")


func _on_area_3d_body_entered(body):
	if body.has_meta(player_meta):
		#print("check_3")
		sinking_animation.play("sinking_start")
		get_tree().change_scene_to_file("res://scenes/bigtitle.tscn")
