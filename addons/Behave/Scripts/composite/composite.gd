extends "res://addons/Behave/Scripts/behavior_tree_node.gd"

var current_child_idx = -1
var children = null
var active_child = null

func on_enter(context):
	.on_enter(context)
	current_child_idx = 0
	children = get_children()
	active_child = children[current_child_idx]
	active_child.on_enter(context)