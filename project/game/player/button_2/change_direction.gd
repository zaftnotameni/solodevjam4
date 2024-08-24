class_name B2ChangeDirection extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var stats := components.resolve_stats()
@onready var input := components.resolve_input()
@onready var default_input := components.resolve_default_input()

func _unhandled_input(event: InputEvent) -> void:
	if DefaultInput.is_event_player_button_two_pressed(event):
		match machine_direction.current_state_id():
			PlayerEnums.Direction.LEFT:
				machine_direction.transition(PlayerEnums.Direction.RIGHT, 'changed-direction')
			PlayerEnums.Direction.RIGHT:
				machine_direction.transition(PlayerEnums.Direction.LEFT, 'changed-direction')
