class_name Config extends Node2D

const GROUP := 'autoload_config'

static func tree() -> SceneTree: return Engine.get_main_loop()
static func first() -> Config: return tree().get_first_node_in_group(GROUP)
static func all() -> Array: return tree().get_nodes_in_group(GROUP)

static var settings : ConfigFile = ConfigFile.new()

static func _static_init() -> void:
	SmartConfig.load_config(settings)
	print_verbose('loading config:\n%s' % settings.encode_to_text())

static func save_settings() -> void:
	SmartConfig.save_config(settings)

