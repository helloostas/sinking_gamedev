extends Node

@export var max_abilities: int = 2
var abilities: Array = []


#Function for adding an ability
func add_ability(ability: Node):
	if abilities.size() >= max_abilities:
		print("Inventory full")
		return false

	abilities.append(ability)
	print("Ability added: %s" % ability.ability_name)
	return true

func use_ability(index: int):
	if index >= 0 and index < abilities.size():
		abilities[index].use_ability()
		if abilities[index].is_used:
			abilities.erase(index)
	else:
		print("Invalid ability index")
		
