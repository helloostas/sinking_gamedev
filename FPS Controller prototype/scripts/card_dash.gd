extends Area3D

var type


# Dash Ability
func _on_body_entered(body):
	if body.has_meta("player"):
		if len(body.on_hand_abilities) <= 1:
			type = body.global_abilities[1]
			body.on_hand_abilities.append(type)
			queue_free()

