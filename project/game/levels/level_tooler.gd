@tool
class_name LevelTooler extends Node

@export var tooled : bool = true : set = set_tooled


var background_decoration_scene : PackedScene = load('res://game/decoration/background_decoration.tscn')
var level_name_scene : PackedScene = load('res://game/decoration/level_name.tscn')
var foreground_tiles_scene : PackedScene = load('res://game/terrain/foreground_tiles.tscn')
var next_level_scene : PackedScene = load('res://game/powerups/power_up_next_level.tscn')
var buttons_scene : PackedScene = load('res://game/hud/buttons.tscn')
var level_dark_light_scene : PackedScene = load('res://game/decoration/level_dark_light.tscn')
var character_scene : PackedScene = load('res://game/player/character.tscn')
var current_time_scene : PackedScene = load('res://game/hud/current_time.tscn')

func on_tooled():
	if not Engine.is_editor_hint(): return
	if not Tool.is_owned_by_edited_scene(self): return
	Tool.remove_all_children_created_via_tool_from(self)
	var at_hud_buttons := AtHUD.new()
	at_hud_buttons.scene = buttons_scene
	at_hud_buttons.name = 'ButtonsHUD'
	var at_hud_time := AtHUD.new()
	at_hud_time.scene = current_time_scene
	at_hud_time.name = 'TimeHUD'
	var spawner := PlayerSpawner.new()
	spawner.active = true
	spawner.spawn_on_ready = true
	spawner.scene = character_scene
	spawner.name = 'PlayerSpawner'
	var background : Node = background_decoration_scene.instantiate()
	background.name = 'Background'
	var foreground : Node = foreground_tiles_scene.instantiate()
	foreground.name = 'Foreground'
	var level_name : Node = level_name_scene.instantiate()
	level_name.name = 'LevelName'
	var next_level : Node = next_level_scene.instantiate()
	next_level.name = 'NextLevel'
	var dark_light : Node = level_dark_light_scene.instantiate()
	dark_light.name = 'DarkLight'
	var camera : Node = CameraFollowsPlayer.new()
	camera.name = 'Camera'
	camera.zoom = Vector2(4, 4)
	camera.process_callback = Camera2D.CAMERA2D_PROCESS_PHYSICS
	var game : Node = StateGame.new()
	game.name = 'StateGame'
	var unpauses : Node = Unpauses.new()
	unpauses.name = 'Unpauses'
	await Tool.tool_add_child(owner, background)
	await Tool.tool_add_child(owner, foreground)
	await Tool.tool_add_child(owner, level_name)
	await Tool.tool_add_child(owner, next_level)
	await Tool.tool_add_child(owner, dark_light)
	await Tool.tool_add_child(owner, spawner)
	await Tool.tool_add_child(owner, camera)
	await Tool.tool_add_child(owner, game)
	await Tool.tool_add_child(owner, unpauses)
	await Tool.tool_add_child(owner, at_hud_buttons)
	await Tool.tool_add_child(owner, at_hud_time)


func set_tooled(v:bool):
	Tool.set_tooled(self, v)

