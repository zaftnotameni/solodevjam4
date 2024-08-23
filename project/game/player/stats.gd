class_name PlayerStats extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var machine_movement := components.resolve_machine_movement()
@onready var machine_direction := components.resolve_machine_direction()
@onready var input := components.resolve_input()

var player_size : Vector2
var tile_size : Vector2
var speed : float
var speed_loss_factor : float
var dash_speed : float
var dash_max_duration : float
var dash_min_duration : float
var jump_velocity : float
var jump_gravity_up : float
var jump_gravity_down : float
var fall_gravity : float
var dash_gravity : float
var max_speed_from_gravity: float
var jump_time_to_peak : float
var jump_time_to_land : float
var jump_height: float
var coyote_duration: float
var jump_buffer_timing: float

func initialize():
	player_size = Vector2(16,16)
	tile_size = Vector2(16,16)
	speed = 80.0
	speed_loss_factor = 10.0
	dash_speed = speed * 4.0
	max_speed_from_gravity = dash_speed * 0.5
	dash_max_duration = 0.5
	dash_min_duration = 0.1
	coyote_duration = 0.1
	jump_buffer_timing = 0.1
	jump_time_to_peak = 0.6
	jump_time_to_land = 0.35
	jump_height = 48.0
	run_kinematic_equations()

func run_kinematic_equations():
	jump_velocity = (2.0 * jump_height) / jump_time_to_peak
	jump_gravity_up = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
	jump_gravity_down = (2.0 * jump_height) / (jump_time_to_land * jump_time_to_land)
	fall_gravity = (jump_gravity_up + jump_gravity_down) / 2.0
	dash_gravity = 0.0

func direction_vector() -> Vector2:
	match machine_direction.current_state_id():
		PlayerEnums.Direction.NONE: return Vector2.ZERO
		PlayerEnums.Direction.RIGHT: return Vector2.RIGHT
		PlayerEnums.Direction.LEFT: return Vector2.LEFT
		_: return Vector2.ZERO

const GROUP := 'player_stats'

func _enter_tree() -> void:
	add_to_group(GROUP)
	initialize()

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> PlayerStats: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)
