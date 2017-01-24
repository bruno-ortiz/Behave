tool

extends Node

signal select_node(node)

var editor_instance = null
var child = null
var tickable_tasks
var open_tasks

var first_tick = true

var context = {
	target = get_parent(),
	tree = self
}

func _ready():
	if not get_tree().is_editor_hint():
		set_process(true)

func _enter_tree():
	node_id = OS.get_ticks_msec()

func _process(delta):
	if first_tick:
		child.on_enter()
	else:
		for t in tickable_tasks:
			t.tick(context)
	pass

func add_node(parent, new_node, position, params = null):
	var root = get_tree().get_edited_scene_root()
	parent.add_child(new_node)
	new_node.set_owner(root)
#	new_node.connect("exit_tree", self, "_on_node_exit_tree", [new_node])
	
