extends "res://addons/Behave/Scripts/behavior_tree_node.gd"

var child = null

func on_enter(context):
	.on_enter(context)
	assert(not get_child_count() > 1)
#	if get_child_count() > 1:
#		print("[WARNING] Decorator has more then one child. Using only first in the tree.")
	child = get_child(0)
	if child:
		child.on_enter(context)