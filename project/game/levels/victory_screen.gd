extends Node2D

@onready var a : Sprite2D = %A
@onready var baba : BABA = %BABA

var scene : PackedScene = load('res://game/levels/leaderboards_screen.tscn')

func _enter_tree() -> void:
	set_process_unhandled_input(false)

func _ready() -> void:
	a.hide()
	baba.sig_show_finished.connect(on_display_finished)

func on_display_finished():
	await get_tree().create_timer(1.0).timeout
	a.show()
	baba.set_process_unhandled_input(false)
	set_process_unhandled_input(true)

func _unhandled_input(event: InputEvent) -> void:
	printt(event, DefaultInput.is_event_player_button_one_pressed(event))
	printt(event, DefaultInput.is_event_player_button_two_pressed(event))
	if DefaultInput.is_event_player_button_one_pressed(event):
		go_to_leaderboards()

func go_to_leaderboards():
	if not scene : return
	var next_level := scene.instantiate()
	print_verbose('next_level %s' % next_level)
	if not next_level : return
	var children_to_wipe := []
	children_to_wipe.append_array(Layers.layer_game().get_children())
	children_to_wipe.append_array(Layers.layer_menu().get_children())
	print_verbose('children_to_wipe:', children_to_wipe)

	var tween := TweenUtil.tween_ignores_pause(TweenUtil.tween_fresh_eased_in_out_cubic())
	tween.chain().tween_interval(0.1)

	for child in children_to_wipe:
		tween.tween_callback(child.queue_free)

	Layers.layer_game().add_child.call_deferred(next_level)
	if not is_queued_for_deletion(): queue_free()

	tween.tween_callback(State.mark_as_game).set_delay(0.1)
	await tween.finished
