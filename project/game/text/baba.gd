class_name BABA extends Node

@export var target_label : Label
@export var target_rich : RichTextLabel
@export var target_line : LineEdit

func _enter_tree() -> void:
	if not target_label and get_parent() is Label: target_label = get_parent()
	if not target_label and not target_rich and get_parent() is RichTextLabel: target_rich = get_parent()
	if not target_label and not target_rich and not target_line and get_parent() is LineEdit: target_line = get_parent()
	if not target_label and owner is Label: target_label = owner
	if not target_label and not target_rich and owner is RichTextLabel: target_rich = owner
	if not target_label and not target_rich and not target_line and owner is LineEdit: target_line = owner
	if not target_label and not target_rich and not target_line: push_error('missing a target')

func _ready() -> void:
	var vowels := RegEx.new()
	var consonants := RegEx.new()
	vowels.compile('([aeiouAEIOU])')
	consonants.compile('([bcdfghjklmnpqrstvwyzBCDFGHJKLMNPQRSTVWYZ])')
	for target:Control in [target_rich, target_label, target_line]:
		if not target: continue
		target.text = vowels.sub(target.text, 'a', true)
		target.text = consonants.sub(target.text, 'b', true)
