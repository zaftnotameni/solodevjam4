class_name CharacterScene extends CharacterBody2D

const GROUP := 'character_scene'

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> CharacterScene: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)

func resolve_components() -> PlayerComponents:
	return Resolve.resolve_at(self, PlayerComponents)

func _enter_tree() -> void:
	add_to_group(GROUP)
	State.first().sig_player_enter.emit()

func _exit_tree() -> void:
	State.first().sig_player_exit.emit()

func _ready() -> void:
	State.first().sig_player_ready.emit()
	%PartySpawn.emitting = true
