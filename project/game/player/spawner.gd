class_name PlayerSpawner extends Area2D

signal sig_spawn_animation_finished()

const GROUP := 'checkpoints'

@export var active : bool = false
@export var spawn_on_ready : bool = true
@export_enum('game', 'menu') var layer : String = 'game'

@export_group('internals')
@export var scene : PackedScene ## PLayer scene
@export var spawning : bool

func _enter_tree() -> void:
	process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS
	add_to_group(GROUP)
	if not scene: scene = load('res://game/player/character.tscn')

func _ready() -> void:
	body_entered.connect(on_body_entered)
	if active: activate()
	if spawn_on_ready: spawn.call_deferred()

func on_body_entered(body:Node2D):
	if body is CharacterScene: activate()

func activate():
	for ps:PlayerSpawner in all():
		if ps != self: ps.deactivate()
	active = true

func spawn():
	if spawning: return
	spawning = true
	for p:CharacterScene in CharacterScene.all():
		p.queue_free()
		await p.tree_exited

	match layer:
		'game':
			if not State.game_state == State.GameState.GAME: await State.first().sig_game_state_game

	if State.transition: await State.first().sig_transition_finished

	var p := scene.instantiate() as Node2D
	p.global_position = global_position

	match layer:
		'game': Layers.layer_game().add_child.call_deferred(p)
		'menu': Layers.layer_menu().add_child.call_deferred(p)

	await p.ready
	sig_spawn_animation_finished.emit()
	spawning = false

func deactivate():
	active = false

static func tree() -> SceneTree: return Engine.get_main_loop()
static func all() -> Array: return tree().get_nodes_in_group(GROUP)
static func current() -> PlayerSpawner:
	for ps:PlayerSpawner in all():
		if ps.active: return ps
	return null
