tool

extends Node

var editor = preload("res://addons/Behave/Editor/Scenes/BehaviorTreeEditor.tscn")

var node_id = -1
var node_cache = {}

var child = null
var tickable_tasks
var open_tasks

var first_tick = true

var context = {
	target = get_parent(),
	tree = self
}

func _ready():
	# TODO: validar aonde inicializar o node_id
	if not get_tree().is_editor_hint():
		set_process(true)
	pass

func _enter_tree():
	node_id = OS.get_ticks_msec()
	_init_node_cache(get_children())

func _process(delta):
	if first_tick:
		child.on_enter()
	else:
		for t in tickable_tasks:
			t.tick(context)
	pass

func add_node(parent_id, new_node, position, params = null):
	var cached_node = _get_node_in_cache(parent_id)
	var root = get_tree().get_edited_scene_root()
	print(root.get_name())
#	root.find_node(cached_node.get_name()).add_child(new_node)
	cached_node.add_child(new_node)
	new_node.set_owner(root)
	new_node.connect("enter_tree", self, "_on_new_node_enter_tree", [new_node, cached_node, position])
	new_node.connect("exit_tree", self, "_on_node_exit_tree", [new_node])

	
func _on_new_node_enter_tree(new_node, parent, position):
	parent.move_child(new_node, position)
	node_cache[new_node.node_id] = new_node

func _on_node_exit_tree(node):
	node_cache.erase(node.node_id)

func _init_node_cache(children):
	node_cache[self.node_id] = self
	for c in children:
		node_cache[c.node_id] = c
		_init_node_cache(c.get_children())
		
func _get_node_in_cache(node_id):
	if node_cache.has(node_id):
		return node_cache[node_id]
	node_cache.clear()
	_init_node_cache(get_children())
	return node_cache[node_id]
	