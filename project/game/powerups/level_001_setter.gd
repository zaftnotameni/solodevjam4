extends Node

var level_001_scene : PackedScene = load('res://game/levels/level_001.tscn')

func _ready() -> void:
	get_parent().scene = level_001_scene
