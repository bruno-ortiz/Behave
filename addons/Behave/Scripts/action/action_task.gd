extends "res://addons/Behave/Scripts/behavior_tree_node.gd"


func on_enter(context):
	.on_enter(context)
	assert(get_children().size() == 0)