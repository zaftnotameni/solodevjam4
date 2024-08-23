class_name PlayerMovementInitial extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()

func _physics_process(_delta: float) -> void:
	if character.is_on_floor():
		machine_movement.transition(PlayerEnums.Movement.GND, 'initial-ground')
	else:
		machine_movement.transition(PlayerEnums.Movement.DSC, 'initial-air')
