extends Node3D
@onready var transition = $transition

# Loads scene animation
func _ready():
	start_function()


func start_function():
	#print("The scene has loaded, and this function is now running!")
	transition.play("fade_in_for level_1")
