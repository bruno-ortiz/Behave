extends "res://addons/Behave/Scripts/behavior_tree_node.gd"

var child = null

func on_enter(context):
	.on_enter(context)
	assert(not get_child_count() > 1)
	child = get_child(0)
	if child:
		child.on_enter(context)