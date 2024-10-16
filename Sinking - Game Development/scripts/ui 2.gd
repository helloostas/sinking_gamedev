extends Control
var cards_string = "transparent_transparent" # Default value

@onready var card_texture = $MarginContainer/card_texture as TextureRect

const CARD_COMBINATIONS = {
	"dash_dash" : "res://godot textures/UI_CARDS/dash_dash.png",
	"dash_double_jump" : "res://godot textures/UI_CARDS/dash_jump.png",
	"dash_sink" : "res://godot textures/UI_CARDS/dash_sink.png",
	"dash_transparent" : "res://godot textures/UI_CARDS/dash_transparent.png",
	
	"double_jump_dash" : "res://godot textures/UI_CARDS/jump_dash.png",
	"double_jump_double_jump" : "res://godot textures/UI_CARDS/jump_jump.png",
	"double_jump_sink" : "res://godot textures/UI_CARDS/jump_sink.png",
	"double_jump_transparent" : "res://godot textures/UI_CARDS/jump_transparent.png",
	
	"sink_dash" : "res://godot textures/UI_CARDS/sink_dash.png",
	"sink_double_jump" : "res://godot textures/UI_CARDS/sink_jump.png",
	"sink_sink" : "res://godot textures/UI_CARDS/sink_sink.png",
	"sink_transparent" : "res://godot textures/UI_CARDS/sink_transparent.png",
	
	"transparent_transparent" : "res://godot textures/UI_CARDS/transparent_transparent.png",
}

func _ready():
	# Call load_card_texture initially with the default or updated cards_string
	load_card_texture()

func update_cards(card_1, card_2):
		cards_string = str(card_1 + "_" + card_2)
		print(cards_string)
		load_card_texture()

func load_card_texture():
	card_texture.texture = load(CARD_COMBINATIONS[cards_string])

#match to texture using dictionary and texture rect
