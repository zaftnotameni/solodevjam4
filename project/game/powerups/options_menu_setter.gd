extends Node

var options_menu_scene : PackedScene = load('res://game/levels/options_screen.tscn')

func _ready() -> void:
	get_parent().scene = options_menu_scene
