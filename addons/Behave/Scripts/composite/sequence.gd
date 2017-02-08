tool

extends "res://addons/Behave/Scripts/composite/composite.gd"



func tick(context):
	var current_status = active_child.status
	if current_status == Status.FAILURE or current_status == Status.TERMINATED:
		return Status.FAILURE
	elif current_status == Status.RUNNING:
		return Status.RUNNING
	current_child_idx += 1
	if current_child_idx < children.size():
		active_child = children[current_child_idx]
		active_child.on_enter(context)
		return Status.RUNNING
	return current_status
	
	
