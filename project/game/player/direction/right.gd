class_name PlayerDirectionRight extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var stats := components.resolve_stats()
@onready var input := components.resolve_input()
@onready var visuals := components.resolve_visuals()

@onready var wall_in_front := %CastDetectWallRight

func on_state_enter(_prev:Node=null) -> void:
	Sfx.flip()
	if get_meta('via_transition', '') == 'bumped-into-wall':
		%PartyWallLeft.emitting = true
		if CameraFollowsPlayer.first():
			CameraFollowsPlayer.first().trauma_request(0.08, 0.1)

func _physics_process(_delta: float) -> void:
	visuals.scale.x = 1
	if wall_in_front.is_colliding():
		machine_direction.transition(PlayerEnums.Direction.LEFT, 'bumped-into-wall')
