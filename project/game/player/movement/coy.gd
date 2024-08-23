class_name PlayerMovementCoy extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var stats := components.resolve_stats()
@onready var input := components.resolve_input()
@onready var gnd := Resolve.resolve_at(get_parent(), PlayerMovementGnd) as PlayerMovementGnd

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
	gnd.apply_gravity(delta)

func apply_auto_movement(delta:float) -> void:
	gnd.apply_auto_movement(delta)

func apply_jump(delta:float) -> void:
	gnd.apply_jump(delta)

func apply_dash(delta:float) -> void:
	gnd.apply_dash(delta)

func _physics_process(delta: float) -> void:
	is_jump = input.is_jump_requested()
	is_dash = input.is_dash_requested()

	apply_gravity(delta)
	apply_auto_movement(delta)

	if is_jump: apply_jump(delta)
	if is_dash: apply_dash(delta)

	character.move_and_slide()
	
	if gnd.gnd_transitions(is_jump, is_dash):
		return

	if character.is_on_floor():
		machine_movement.transition(PlayerEnums.Movement.GND, 'uncoyote')
		return

	elapsed += delta
	if elapsed >= stats.coyote_duration:
		machine_movement.transition(PlayerEnums.Movement.DSC, 'fell')
