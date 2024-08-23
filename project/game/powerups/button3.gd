class_name PowerUpButton3 extends BasePowerUp

@export var what : PlayerEnums.Button3

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_character_enter(character:CharacterScene):
	var machine := character.resolve_components().resolve_machine_button3()
	machine.transition(what, 'button-3-changed')
	if ephemeral: queue_free()

func on_body_entered(body:Node2D):
	if body is CharacterScene: on_character_enter(body)
