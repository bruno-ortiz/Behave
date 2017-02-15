extends "res://addons/Behave/Scripts/behavior_tree_node.gd"

var children = null

var Decorator = preload("res://addons/Behave/Scripts/decorator/decorator.gd")
var Composite = get_script()

func on_enter(context):
	.on_enter(context)
	children = get_children()
	var parent = get_parent()
	if parent and not (parent extends Composite or parent extends Decorator):
		context.tree.insertion_requests.append(self)