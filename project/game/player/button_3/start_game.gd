class_name B3StartGame extends Node2D

@onready var character : CharacterScene = owner
@onready var components : PlayerComponents = PlayerComponents.resolve(character)
@onready var input := components.resolve_input()

var level001_scene : PackedScene = load('res://game/levels/level_001.tscn')

func _unhandled_input(event: InputEvent) -> void:
	if input.is_button_three_pressed(event):
		get_viewport().set_input_as_handled()
		set_process_unhandled_input(false)
		
		await start_game()

func start_game():
	var level001 := level001_scene.instantiate()
	var children_to_wipe := []
	children_to_wipe.append_array(Layers.layer_game().get_children())
	children_to_wipe.append_array(Layers.layer_menu().get_children())

	var tween = TweenUtil.tween_ignores_pause(TweenUtil.tween_fresh_eased_in_out_cubic())

	for c:CharacterScene in CharacterScene.all():
		c.process_mode = Node.PROCESS_MODE_DISABLED

	for ft:ForegroundTilesScene in ForegroundTilesScene.all():
		for coords:Vector2i in ft.get_used_cells():
			tween.parallel().tween_callback(ft.erase_cell.bind(coords)).set_delay(randf_range(0.05, 0.3))

	tween.tween_callback(wipe_all.bind(children_to_wipe))
	
	await tween.finished

	Layers.layer_game().add_child.call_deferred(level001)

func wipe_all(children:Array=[]):
	print(children)
	for child in children:
		print_verbose('deleting: ', child.get_path())
		child.queue_free()

