extends Area3D

var type
var player_position
@onready var player = $"../player"

#func _process(delta):
	#player_position = player.position 
	#look_at(player_position)
	#rotation.x = clamp(player_position.y, deg_to_rad(0), deg_to_rad(0))
	
func _process(delta):
	player_position = player.position
	look_at(player_position)
	rotation.x = clamp(player_position.y, deg_to_rad(0), deg_to_rad(0))

# Dash Ability
func _on_body_entered(body):
	if body.has_meta("player"):
		if len(body.on_hand_abilities) <= 1:
			type = body.global_abilities[1]
			body.on_hand_abilities.append(type)
			queue_free()
