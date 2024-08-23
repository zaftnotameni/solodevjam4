class_name PlayerDirectionRight extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var stats := components.resolve_stats()
@onready var input := components.resolve_input()
@onready var visuals := components.resolve_visuals()

@onready var wall_in_front := %CastDetectWallRight

func _physics_process(_delta: float) -> void:
	visuals.scale.x = 1
	if wall_in_front.is_colliding():
		machine_direction.transition(PlayerEnums.Direction.LEFT, 'bumped-into-wall')
