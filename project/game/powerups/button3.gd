class_name PowerUpButton3 extends BasePowerUp

@export var what : PlayerEnums.Button3
@export var scene : PackedScene

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_character_enter(character:CharacterScene):
	var machine := character.resolve_components().resolve_machine_button3()
	machine.transition(what, 'button-3-changed')
	if ephemeral: queue_free()

func on_body_entered(body:Node2D):
	if body is CharacterScene: on_character_enter(body)

func go_to_next_level():
	if not scene : return
	var next_level := scene.instantiate()
	if not next_level : return
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

	Layers.layer_game().add_child.call_deferred(next_level)

func wipe_all(children:Array=[]):
	for child in children:
		print_verbose('deleting: ', child.get_path())
		child.queue_free()
