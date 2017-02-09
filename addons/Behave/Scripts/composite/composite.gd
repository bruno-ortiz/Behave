extends "res://addons/Behave/Scripts/behavior_tree_node.gd"

var children = null

func on_enter(context):
	.on_enter(context)
	children = get_children()