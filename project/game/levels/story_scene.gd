extends Node2D

@export var named : Named

@onready var a : Sprite2D = %A
@onready var with_name : Node2D = %WithName
@onready var no_name : Node2D = %NoName
@onready var ask_name : Node2D = %AskName
@onready var baba_no : BABA = %BABANo
@onready var baba_ask : BABA = %BABAAsk
@onready var baba_with : BABA = %BABAWith
@onready var baba_button : BABA = %BABAButton
@onready var name_input : LineEdit = %NameLine
@onready var name_button : BaseButton = %NameButton

@export_group('internals')
@export var player_name : String

var title_screen_scene : PackedScene = load('res://game/levels/title_screen.tscn')

enum Named { NOPE = 0, ASK, YEAP }

func on_with_display_finished():
	Layers.layer_game().add_child.call_deferred(title_screen_scene.instantiate())
	queue_free()

func on_ask_display_finished():
	pass

func on_no_display_finished():
	update_named_state(Named.ASK)

func on_name_input_changed(new_text:String):
	player_name = new_text

func on_name_button_pressed():
	if player_name and not player_name.is_empty():
		Config.set_player_name(player_name)
		update_named_state(Named.YEAP)

func _ready() -> void:
	baba_with.sig_display_finished.connect(on_with_display_finished)
	baba_ask.sig_display_finished.connect(on_ask_display_finished)
	baba_no.sig_display_finished.connect(on_no_display_finished)
	name_input.text_changed.connect(on_name_input_changed)
	name_button.pressed.connect(on_name_button_pressed)
	player_name = Config.get_player_name()
	if player_name and not player_name.is_empty():
		named = Named.YEAP
	else:
		named = Named.NOPE
	active_baba_process_input()
	show_active()
	
func active_baba_process_input():
	baba_process_no_input()
	match named:
		Named.NOPE:
			baba_no.set_process_unhandled_input(true)
		Named.ASK:
			baba_ask.set_process_unhandled_input(true)
		Named.YEAP:
			baba_with.set_process_unhandled_input(true)

func show_active():
	hide_all()
	match named:
		Named.NOPE:
			a.show()
			no_name.show()
		Named.ASK:
			a.hide()
			ask_name.show()
			name_input.grab_focus.call_deferred()
		Named.YEAP:
			a.show()
			with_name.show()

func hide_all():
	with_name.hide()
	ask_name.hide()
	no_name.hide()

func baba_process_no_input():
	baba_button.set_process_unhandled_input(false)
	baba_with.set_process_unhandled_input(false)
	baba_ask.set_process_unhandled_input(false)
	baba_no.set_process_unhandled_input(false)

func update_named_state(new_named_state:Named=named):
	if named == new_named_state: return
	named = new_named_state
	active_baba_process_input()
	show_active()
