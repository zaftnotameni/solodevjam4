class_name ForegroundTilesScene extends TileMapLayer

const GROUP := 'foreground_tiles_scene'

func _enter_tree() -> void:
	add_to_group(GROUP)

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> ForegroundTilesScene: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)
