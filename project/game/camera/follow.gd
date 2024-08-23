class_name CameraFollowsPlayer extends Camera2D

## How quickly the shaking stops [0, 1].
@export var decay : float = 0.8
## Maximum hor/ver shake in pixels.
@export var max_offset := Vector2(100, 75)
## Maximum rotation in radians (use sparingly).
@export var max_roll : float = 0.1
## Assign the node this camera will follow.
@export var target : NodePath
## Current shake strength.
@export var trauma : float = 0.0
## Current constant shake strength, setting this will make the camera shake until its set back to 0.
@export var constant_trauma : float = 0.0
## Trauma exponent. Use [2, 3].
@export var trauma_power : float = 2
## Target to follow
@export var follow_target : Node2D
## Follow factor
@export var follow_factor : float = 400

func trauma_request(t:float, m:float=0.3):
	trauma = m if (trauma + t >= m) else trauma + t

func trauma_relief(t:float):
	trauma = clamp(trauma - t, 0, 1.0)

func trauma_clear():
	trauma = 0

func constant_trauma_request(t:float, m:float=0.3):
	constant_trauma = m if (constant_trauma + t >= m) else constant_trauma + t

func constant_trauma_relief(t:float):
	constant_trauma = clamp(constant_trauma - t, 0, 1.0)

func constant_trauma_clear():
	constant_trauma = 0.0

func with_zoom(z:float=1) -> CameraFollowsPlayer:
	zoom = Vector2(z,z)
	return self

func on_player_ready():
	follow_target = CharacterScene.first()

func on_player_exit():
	follow_target = null

func _ready() -> void:
	State.first().sig_player_ready.connect(on_player_ready)
	State.first().sig_player_exit.connect(on_player_exit)
	follow_target = CharacterScene.first()
	setup_boundaries()
	make_current()

func do_follow_target(n:Node2D,d:float) -> void:
	global_position = global_position.move_toward(n.global_position, d * follow_factor)

func _physics_process(delta: float) -> void: do_process(delta)

func do_process(delta:float):
	if follow_target: do_follow_target(follow_target,delta)
	if constant_trauma and not is_zero_approx(constant_trauma) and constant_trauma > 0:
		shake_pure_random(constant_trauma)
	elif trauma:
		trauma = max(trauma - decay * delta, 0)
		shake_pure_random(trauma)

func shake_pure_random(t:=trauma):
	var amount = pow(t, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)

const GROUP := 'camera_follows_player'

func _enter_tree() -> void:
	add_to_group(GROUP)
	set_process(false)
	set_physics_process(true)

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> CameraFollowsPlayer: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)

var min_x : float = 1000000
var min_y : float = 1000000
var max_x : float = -1000000
var max_y : float = -1000000

func setup_boundaries():
	var layer := ForegroundTilesScene.first()
	if not layer: return
	for cell in layer.get_used_cells():
		var glopos := layer.to_global(layer.map_to_local(cell))
		min_x = min(min_x, glopos.x)
		min_y = min(min_y, glopos.y)
		max_x = max(max_x, glopos.x)
		max_y = max(max_y, glopos.y)
	limit_left = roundi(min_x - 16 * 1)
	limit_right = roundi(max_x + 16 * 1)
	limit_top = roundi(min_y - 16 * 1)
	limit_bottom = roundi(max_y + 16 * 1)
