class_name PlayerMovementDsh extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var stats := components.resolve_stats()
@onready var input := components.resolve_input()

var elapsed : float = 0.0
var is_dash_cancelled : bool

func on_state_exit(_next:Node=null) -> void:
	elapsed = 0.0
	is_dash_cancelled = false

func on_state_enter(_prev:Node=null) -> void:
	Sfx.dash()
	elapsed = 0.0
	is_dash_cancelled = false

func apply_gravity(delta:float) -> void:
	character.velocity.y += stats.dash_gravity * delta

func apply_auto_movement(_delta:float) -> void:
	character.velocity.x = stats.dash_speed * stats.direction_vector().x

func apply_jump(_delta:float) -> void:
	character.velocity.y = -stats.jump_velocity

func _physics_process(delta: float) -> void:
	var is_jump := input.is_jump_requested()
	is_dash_cancelled = is_dash_cancelled or input.is_dash_cancelled()

	apply_gravity(delta)
	apply_auto_movement(delta)

	if is_jump: apply_jump(delta)

	character.move_and_slide()

	if is_jump:
		machine_movement.transition(PlayerEnums.Movement.ASC, 'jump')
		return

	elapsed += delta
	if is_dash_cancelled and elapsed >= stats.dash_min_duration:
		leave_state_check()
		return
	if elapsed >= stats.dash_max_duration:
		leave_state_check()
		return

func leave_state_check():
	if character.is_on_floor():
		machine_movement.transition(PlayerEnums.Movement.GND, 'dash-ended-gnd')
		return
	else:
		machine_movement.transition(PlayerEnums.Movement.COY, 'dash-ended-coy')
		return


