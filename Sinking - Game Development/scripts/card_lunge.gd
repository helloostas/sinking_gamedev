extends Area3D
@onready var player = $"../player"

# Defining Variables
var type
var player_position
var player_meta = "player"

# Card Rotation
func _process(delta):
	player_position = player.position
	look_at(player_position)
	rotation.x = clamp(player_position.y, deg_to_rad(0), deg_to_rad(0))


# Lunge Ability
func _on_body_entered(body):
	if body.has_meta(player_meta):
		if len(body.on_hand_abilities) <= 1:
			type = body.global_abilities[3]
			body.on_hand_abilities.append(type)
			body.card_collected()
			queue_free()
