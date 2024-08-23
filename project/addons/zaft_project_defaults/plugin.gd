@tool
extends EditorPlugin

static var pallete_colors := []

func _enter_tree() -> void:
	print_verbose('=> activating zaft_project_defaults')
	print_verbose('=> setting up project metadata')
	await setup_default_project_metadata()
	print_verbose('=> setup up project metadata')
	print_verbose('=> setting up project settings')
	setup_default_project_settings()
	print_verbose('=> setup up project settings')
	print_verbose('=> setting up input actions')
	setup_default_input_actions()
	print_verbose('=> setup up input actions')
	print_verbose('=> activated zaft_project_defaults')

func _exit_tree() -> void:
	print_verbose('=> deactivating zaft_project_defaults')

static func tree() -> SceneTree: return Engine.get_main_loop()

func setup_default_project_metadata():
	var pallete_file_path = 'res://addons/zaft_project_defaults/palette.hex'
	var project_metadata_file_path := 'res://.godot/editor/project_metadata.cfg'
	var hex_file_url := ''
	hex_file_url = 'https://lospec.com/palette-list/purplemorning8.hex'
	hex_file_url = 'https://lospec.com/palette-list/vaporcraze-8.hex'

	if not FileAccess.file_exists(pallete_file_path):
		print_verbose('downloading: ' + hex_file_url)
		var http_request := HTTPRequest.new()
		http_request.download_file = pallete_file_path
		add_child(http_request)
		await http_request.ready
		print_verbose('downloading: ' + hex_file_url)
		http_request.request(hex_file_url)
		http_request.request_completed.connect(func(res, status, headers, body:PackedByteArray): printt(res, status, headers, body))
		await http_request.request_completed
		http_request.queue_free()

	var fa := FileAccess.open(pallete_file_path, FileAccess.READ)
	var lines := fa.get_as_text().split('\n')
	fa.close()
	for line:String in lines:
		if not line or line.is_empty(): continue
		pallete_colors.push_back(Color('#' + line.strip_edges()))

	pallete_colors.sort_custom(func (a:Color, b:Color): return a.get_luminance() < b.get_luminance())

	var editor_settings := EditorInterface.get_editor_settings()
	var preset_colors := editor_settings.get_project_metadata('color_picker', 'presets', PackedColorArray([])) as PackedColorArray
	var colors_to_add := []
	var preset_colors_as_html := []
	for color in preset_colors:
		preset_colors_as_html.push_back(color.to_html())
	for color in pallete_colors:
		if preset_colors_as_html.has(color.to_html()): continue
		colors_to_add.push_back(color)
	for color in colors_to_add:
		preset_colors.push_back(color)
	if colors_to_add.is_empty(): return
	printt('colors to add', colors_to_add.map(func (c): return c.to_html()))
	editor_settings.set_project_metadata('color_picker', 'presets', preset_colors)

func setup_default_project_settings():
	var folder_colors := {
		"res://addons/": "gray",
		"res://game/": "purple",
		"res://lib/": "red",
		"res://test/": "pink",
		"res://generated/": "green",
		"res://assets/": "orange",
	}
	var project_settings = {
		'application/config/name': 'Solo Jam 4',
		'audio/buses/default_bus_layout': 'res://addons/zaft_project_defaults/audio/default_bus_layout.tres',
		'debug/gdscript/warnings/unused_signal': 0,
		'display/window/size/viewport_width': 1366,
		'display/window/size/viewport_height': 768,
		'display/window/stretch/mode': 'viewport',
		'file_customization/folder_colors': folder_colors,
		'rendering/textures/canvas_textures/default_texture_filter': 0,
		'rendering/viewport/hdr_2d': true,
		'rendering/environment/defaults/default_clear_color': Color.HOT_PINK if pallete_colors.is_empty() else pallete_colors[0],
		'rendering/environment/defaults/default_environment': 'res://addons/zaft_project_defaults/world/default_world_environment.tres',
		'editor/naming/script_name_casing': 2,
		'editor/naming/scene_name_casing': 2,
		'physics/common/physics_interpolation': true,
		'physics/2d/run_on_separate_thread': true,
	}
	if project_settings.keys().reduce(func (changed, key):
		var new_val = project_settings.get(key)
		var old_val = ProjectSettings.get_setting(key)
		var different : bool = new_val != old_val
		if new_val is Color and old_val is Color: different = new_val.to_html() != old_val.to_html()
		if different: ProjectSettings.set_setting(key, new_val)
		return changed or different, false):
		ProjectSettings.save()

func setup_default_input_actions():
	var input_actions := [
		#'pause',
		#'unpause',
		#'menu_close',
		#'menu_accept',
		#'menu_back',
		#'player_up',
		#'player_down',
		#'player_left',
		#'player_right',
		#'player_jump',
		#'player_dash',
		#'player_roll',
		#'player_attack',
		#'player_interact',
		#'player_use',
		#'player_button_one',
		#'player_button_two',
	]
	var project_settings = {}
	for input_action in input_actions:
		if not InputMap.has_action(input_action):
			project_settings['input/' + input_action] = { 'deadzone': 0.5, 'events': [] }
	if project_settings.keys().reduce(func (changed, key):
		var new_val = project_settings.get(key)
		var old_val = ProjectSettings.get_setting(key)
		var different : bool = new_val != old_val
		if different: ProjectSettings.set_setting(key, new_val)
		return changed or different, false):
		ProjectSettings.save()
