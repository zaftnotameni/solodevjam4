extends Area2D

@onready var col : CollisionShape2D = $CollisionShape2D
@onready var con : Node = get_parent().get_node('Controller')

func on_character_entered(character:CharacterScene):
	var rect : RectangleShape2D = col.shape
	var percentage := clampf(character.global_position.x - (global_position.x - rect.size.x * 0.5), 0.0, 100.0)
	percentage = snappedf(percentage, 5.0)
	con.on_value_changed(percentage)

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body:Node2D):
	if body is CharacterScene: on_character_entered(body)

