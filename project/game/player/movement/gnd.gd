class_name PlayerMovementGnd extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var stats := components.resolve_stats()
@onready var input := components.resolve_input()
@onready var dsh := Resolve.resolve_at(get_parent(), PlayerMovementDsh) as PlayerMovementDsh
@onready var asc := Resolve.resolve_at(get_parent(), PlayerMovementAsc) as PlayerMovementAsc

var elapsed : float = 0.0
var is_jump_cancelled : bool
var is_jump : bool
var is_dash : bool

func on_state_exit(_next:Node=null) -> void:
	elapsed = 0.0
	is_jump_cancelled = false
	is_jump = false
	is_dash = false

func on_state_enter(_prev:Node=null) -> void:
	elapsed = 0.0
	is_jump_cancelled = false
	is_jump = false
	is_dash = false

func apply_gravity(delta:float) -> void:
	character.velocity.y += stats.jump_gravity_down * delta

func apply_auto_movement(delta:float) -> void:
	var velocity_and_direction_match : bool = is_equal_approx(sign(character.velocity.x), sign(stats.direction_vector().x))
	var speed_is_above_default : bool = abs(character.velocity.x) > abs(stats.speed)

	if velocity_and_direction_match and speed_is_above_default:
		character.velocity.x = move_toward(character.velocity.x, stats.speed, stats.speed_loss_factor * delta)
	else:
		character.velocity.x = stats.speed * stats.direction_vector().x

func apply_jump(_delta:float) -> void:
	character.velocity.y = -stats.jump_velocity

func apply_dash(_delta:float) -> void:
	character.velocity.x = stats.dash_speed * stats.direction_vector().x

func _physics_process(delta: float) -> void:
	is_jump = input.is_jump_requested()
	is_dash = input.is_dash_requested()

	apply_gravity(delta)
	apply_auto_movement(delta)

	if is_jump: apply_jump(delta)
	if is_dash: apply_dash(delta)

	character.move_and_slide()

	if gnd_transitions(is_jump, is_dash):
		return

	if not character.is_on_floor():
		machine_movement.transition(PlayerEnums.Movement.COY, 'coyote')
		return

func gnd_transitions(is_jmp:bool, is_dsh:bool) -> bool:
	if is_jmp:
		machine_movement.transition(PlayerEnums.Movement.ASC, 'jump')
		return true
	if is_dsh:
		machine_movement.transition(PlayerEnums.Movement.DSH, 'dash')
		return true
	return false
