extends "res://addons/Behave/Scripts/behavior_tree_node.gd"

func _init(params=null):
	pass

func on_enter(context):
	status = Status.RUNNING
	context.tree.tickable_tasks.append(self)

func tick(context):
	pass
	
func on_exit(context):
	pass
	
func get_behavior_type():
	return "Action"