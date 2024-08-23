@tool
extends EditorPlugin

const AUTOLOADS := ['config', 'state', 'layers', 'audio']

func _enter_tree() -> void:
	for_each_autoload(func (autoload:String):
		add_autoload_singleton('__%s' % autoload, "./%s/autoload.tscn" % autoload))

func _exit_tree() -> void:
	for_each_autoload(func (autoload:String):
		add_autoload_singleton('__%s' % autoload, "./%s/autoload.tscn" % autoload), true)

static func for_each_autoload(fn:Callable, reversed:bool=false):
	for i in AUTOLOADS.size(): fn.call(AUTOLOADS[(-1 - i) if reversed else i])

