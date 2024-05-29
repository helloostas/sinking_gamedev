# Ability.gd
extends Node

@export var ability_name: String
@export var cooldown: float
@export var is_used: bool = false

func use_ability():
	if is_used:
		print("Ability already used") # Will need to change to a graphical interface later
		return
		
	# Define what the ability does
	_apply_ability_effect()
	is_used = true
	print("Ability used: %s" % ability_name)

func _apply_ability_effect():
	# Implement this in subclasses
	pass
