@tool
class_name AutoFollowPath extends PathFollow2D

@export_group('configuration')
@export var speed : float = 0.05
@export var reverse : bool = false

func _enter_tree() -> void:
	set_physics_process(not Engine.is_editor_hint())
	if not Engine.is_editor_hint(): return
	if not Tool.is_owned_by_edited_scene(self): return
	rotates = false
	rotation = 0

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		rotates = false
		rotation = 0
		set_physics_process(not Engine.is_editor_hint())
	if Engine.is_editor_hint(): return
	progress_ratio += delta * speed * (-1 if reverse else 1)
	if progress_ratio < 0: progress_ratio = 1
	if progress_ratio > 1: progress_ratio = 0
