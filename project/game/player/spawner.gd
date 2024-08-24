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
	if Engine.is_editor_hint(): return
	process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS
	add_to_group(GROUP)
	if not scene: scene = load('res://game/player/character.tscn')

func _ready() -> void:
	if Engine.is_editor_hint(): return
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

	if State.first():
		match layer:
			'game':
				if not State.game_state == State.GameState.GAME: await State.first().sig_game_state_game

	if State.transition: await State.first().sig_transition_finished

	var p := scene.instantiate() as CharacterScene
	p.global_position = global_position

	if Layers.first():
		match layer:
			'game': Layers.layer_game().add_child.call_deferred(p)
			'menu': Layers.layer_menu().add_child.call_deferred(p)

	await p.ready
	sig_spawn_animation_finished.emit()
	spawning = false

	match layer:
		'game':
			p.process_mode = Node.PROCESS_MODE_INHERIT
		'menu':
			p.resolve_components().resolve_machine_direction().transition(PlayerEnums.Direction.LEFT, 'menu')
			p.process_mode = Node.PROCESS_MODE_ALWAYS

func deactivate():
	active = false

static func tree() -> SceneTree: return Engine.get_main_loop()
static func all() -> Array: return tree().get_nodes_in_group(GROUP)
static func current() -> PlayerSpawner:
	for ps:PlayerSpawner in all():
		if ps.active: return ps
	return null
