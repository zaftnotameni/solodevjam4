class_name PlayerComponents extends Node2D

const GROUP := 'player_components'

@onready var machine_movement := resolve_machine_movement()
@onready var machine_direction := resolve_machine_direction()
@onready var machine_button0 := resolve_machine_button0()
@onready var machine_button1 := resolve_machine_button1()
@onready var machine_button2 := resolve_machine_button2()
@onready var machine_button3 := resolve_machine_button3()
@onready var machine := resolve_machine()
@onready var stats := resolve_stats()
@onready var input := resolve_input()
@onready var default_input := resolve_default_input()
@onready var visuals := resolve_visuals()

func resolve_machine_movement() -> StateMachine: return Resolve.resolve_meta_from(owner, 'machine_type', 'movement')
func resolve_machine_direction() -> StateMachine: return Resolve.resolve_meta_from(owner, 'machine_type', 'direction')
func resolve_machine_button0() -> StateMachine: return Resolve.resolve_meta_from(owner, 'machine_type', 'button0')
func resolve_machine_button1() -> StateMachine: return Resolve.resolve_meta_from(owner, 'machine_type', 'button1')
func resolve_machine_button2() -> StateMachine: return Resolve.resolve_meta_from(owner, 'machine_type', 'button2')
func resolve_machine_button3() -> StateMachine: return Resolve.resolve_meta_from(owner, 'machine_type', 'button3')
func resolve_machine() -> PlayerStateMachine: return Resolve.resolve_from(owner, PlayerStateMachine)
func resolve_stats() -> PlayerStats: return Resolve.resolve_from(owner, PlayerStats)
func resolve_input() -> PlayerInput: return Resolve.resolve_from(owner, PlayerInput)
func resolve_default_input() -> DefaultInput: return Resolve.resolve_from(owner, DefaultInput)
func resolve_visuals() -> PlayerVisuals: return Resolve.resolve_at(owner, PlayerVisuals)

static func resolve(character_scene:CharacterScene) -> PlayerComponents:
	return Resolve.resolve_at(character_scene, PlayerComponents)

func _enter_tree() -> void:
	add_to_group(GROUP)

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> PlayerComponents: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)

