class_name PowerUpButton2 extends BasePowerUp

@export var what : PlayerEnums.Button2

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_character_enter(character:CharacterScene):
	var machine := character.resolve_components().resolve_machine_button2()
	machine.transition(what, 'button-2-changed')
	if ephemeral: queue_free()

func on_body_entered(body:Node2D):
	if body is CharacterScene: on_character_enter(body)

