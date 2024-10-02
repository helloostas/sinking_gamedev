extends Node3D

@onready var transition = $transition

func _ready():
	# This code will run when the scene loads
	start_function()

func start_function():
	print("The scene has loaded, and this function is now running!")
	transition.play("fade_in_for level_1")
