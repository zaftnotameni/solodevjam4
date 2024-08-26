class_name BABA extends Node

signal sig_display_finished()
signal sig_show_finished()

@export var target_label : Label
@export var target_rich : RichTextLabel
@export var target_line : LineEdit
@export var target_button : BaseButton
@export var no_baba : bool = false
@export var no_type : bool = false

@export_group('internals')
@export var original_text : String
@export var baba_text : String

func _enter_tree() -> void:
	if not target_label and get_parent() is Label: target_label = get_parent()
	if not target_label and not target_rich and get_parent() is RichTextLabel: target_rich = get_parent()
	if not target_label and not target_rich and not target_line and get_parent() is LineEdit: target_line = get_parent()
	if not target_label and not target_rich and not target_line and not target_button and get_parent() is BaseButton: target_button = get_parent()
	if not target_label and owner is Label: target_label = owner
	if not target_label and not target_rich and owner is RichTextLabel: target_rich = owner
	if not target_label and not target_rich and not target_line and owner is LineEdit: target_line = owner
	if not target_label and not target_rich and not target_line and not target_button and owner is BaseButton: target_button = owner
	if not target_label and not target_rich and not target_line and not target_button: push_error('missing a target')

var tween : Tween

func targets() -> Array[Control]:
	return [target_rich, target_label, target_line, target_button]

func _unhandled_input(event: InputEvent) -> void:
	if DefaultInput.is_event_player_button_one_pressed(event) and (tween and tween.is_running()):
		get_viewport().set_input_as_handled()
		tween.kill()
		for target:Control in targets():
			if not target: continue
			target.text = baba_text
		sig_show_finished.emit()
		return
	if DefaultInput.is_event_player_button_one_pressed(event) and (not tween or not tween.is_running()):
		get_viewport().set_input_as_handled()
		sig_display_finished.emit()

static func babafy(txt:String) -> String:
	if Config.get_last_victory() > 10: return txt
	var vowels := RegEx.new()
	var consonants := RegEx.new()
	vowels.compile('([eiouEIOU])')
	consonants.compile('([dfghjklmnpqrstvwyzDFGHJKLMNPQRSTVWYZ])')
	var babafied := txt
	babafied = vowels.sub(txt, 'a', true)
	babafied = consonants.sub(babafied, 'b', true)
	return babafied

func _exit_tree() -> void:
	if tween and tween.is_running(): tween.kill()

func _ready() -> void:
	var player_name := Config.get_player_name()
	for target:Control in targets():
		if not target: continue
		original_text = target.text
		if player_name and not player_name.is_empty():
			original_text = original_text.replace('PLAYER_NAME', player_name)
		baba_text = original_text if no_baba else BABA.babafy(original_text)
		if no_type:
			target.text = baba_text
			return
		target.text = ''
		tween = TweenUtil.tween_ignores_pause(TweenUtil.tween_fresh_eased_in_out_cubic(tween))
		for i in baba_text.length():
			var txt = baba_text.substr(0, i + 1)
			tween.tween_property(target, 'text', txt, 0.02)
		await tween.finished
		sig_show_finished.emit()
