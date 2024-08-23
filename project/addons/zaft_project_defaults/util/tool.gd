class_name Tool extends RefCounted

static func set_tooled(node:Node, v):
	if v: return
	if not v and node.has_method('on_tooled'):
		node.on_tooled()
	node.set('tooled', true)

static func is_owned_by_edited_scene(node:Node) -> bool:
	if not node: return false
	if not node.get_tree(): return false
	if not node.get_tree().edited_scene_root: return false
	if not node.owner: return false
	if node.get_tree().edited_scene_root == node.owner: return true
	return false

static func is_root_of_edited_scene(node:Node) -> bool:
	if not node: return false
	if not node.get_tree(): return false
	if not node.get_tree().edited_scene_root: return false
	if not node.owner: return false
	if node.get_tree().edited_scene_root == node: return true
	return false

static func tool_add_child(parent:Node, child:Node):
	parent.add_child.call_deferred(child)
	await child.ready
	child.set_meta('created_via_tool_script', true)
	child.owner = parent.get_tree().edited_scene_root

static func remove_all_children_created_via_tool_from(node:Node):
	for child:Node in node.get_children():
		if not child.get_meta('created_via_tool_script', false): continue
		printt('tool removing child', child, child.name)
		child.queue_free()
		await child.tree_exited

static func remove_all_children_dangerously_from(node:Node):
	for child:Node in node.get_children():
		child.queue_free()
		await child.tree_exited
