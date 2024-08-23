class_name PlayerMovementDsc extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var stats := components.resolve_stats()
@onready var input := components.resolve_input()
@onready var gnd := Resolve.resolve_at(get_parent(), PlayerMovementGnd) as PlayerMovementGnd
@onready var asc := Resolve.resolve_at(get_parent(), PlayerMovementAsc) as PlayerMovementAsc

var elapsed : float = 0.0
var is_jump_cancelled : bool

func on_state_exit(_next:Node=null) -> void:
	elapsed = 0.0
	is_jump_cancelled = false

func on_state_enter(_prev:Node=null) -> void:
	elapsed = 0.0
	is_jump_cancelled = false

func apply_gravity(delta:float) -> void:
	character.velocity.y += stats.jump_gravity_down * delta
	character.velocity.y = minf(character.velocity.y, stats.max_speed_from_gravity)

func apply_auto_movement(delta:float) -> void:
	asc.apply_auto_movement(delta)

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	apply_auto_movement(delta)

	character.move_and_slide()

	if character.is_on_floor():
		machine_movement.transition(PlayerEnums.Movement.GND, 'land')
		return

