class_name BackgroundTilesScene extends TileMapLayer

const GROUP := 'background_tiles_scene'

func _enter_tree() -> void:
	add_to_group(GROUP)

func _ready() -> void:
	pass
	#await get_tree().create_timer(0.1).timeout
	#setup_boundaries.call_deferred()

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
	var limit_left := roundi(min_x - 16 * 1)
	var limit_right := roundi(max_x + 16 * 1)
	var limit_top := roundi(min_y - 16 * 1)
	var limit_bottom := roundi(max_y + 16 * 1)
	var counter : int = 0
	for x in range(limit_left * 0.5, limit_right * 0.5):
		if is_queued_for_deletion(): break
		for y in range(limit_top * 0.5, limit_bottom * 0.5):
			if is_queued_for_deletion(): break
			set_cell(local_to_map(to_local(Vector2i(x * 2, y * 2))), 0, Vector2i(randi_range(0, 8), 59))
			counter += 1
			if counter > 512:
				await get_tree().process_frame
				counter = 0

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> BackgroundTilesScene: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)
